{ pkgs, lib, ... }:

let
  i-tools = pkgs.interception-tools;

  # Need this commit for AFTER_RELEASE to work (used for auto-shift keys):
  # https://gitlab.com/interception/linux/plugins/dual-function-keys/-/commit/578d00f2eb74a0f74c2ba759312d7fc4c82725a1
  # Opened nixpkgs PR to update the pkg: https://github.com/NixOS/nixpkgs/pull/275026
  dual-fn-keys-pkg = pkgs.interception-tools-plugins.dual-function-keys.overrideAttrs (finalAttrs: {
    version = "1.5.0";
    src = pkgs.fetchFromGitLab {
      group = "interception";
      owner = "linux/plugins";
      repo = finalAttrs.pname;
      rev = finalAttrs.version;
      hash = "sha256-m/oEczUNKqj0gs/zMOIBxoQaffNg+YyPINMXArkATJ4=";
    };
  });

  # Helper to write data structure as a json file
  toJsonFile = filename: content: builtins.toFile filename (builtins.toJSON content);

  # Helper to define an input pipeline job, with a list of input processors
  inputPipelineJob = inputProcessors: (
    if builtins.typeOf inputProcessors != "list" || builtins.length inputProcessors == 0 then
      throw "Input pipeline for udevmon must be a non-empty list!"
    else
      "${i-tools}/bin/intercept -g $DEVNODE | ${builtins.concatStringsSep "|" inputProcessors} | ${i-tools}/bin/uinput -d $DEVNODE"
  );
in {
  # interception-tools' pipeline can be very flexible
  #   https://gitlab.com/interception/linux/tools
  #
  # Plugin for dual-function-keys:
  #   https://gitlab.com/interception/linux/plugins/dual-function-keys
  #
  # To find the key names, use `sudo showkey` to show raw keycodes and use the corresponding
  # name from <https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h>.
  #
  # Great literature on dual function key behaviors:
  #   https://docs.qmk.fm/#/tap_hold
  services.interception-tools = {
    enable = true;
    # $PATH (extended by 'plugins' option) isn't passed down to job specified in the config
    # This is tracked in these issues:
    # - https://github.com/NixOS/nixpkgs/issues/126681
    # - https://gitlab.com/interception/linux/tools/-/issues/58
    # So we specify full path to the various tools in config for now.
    plugins = [];
    udevmonConfig = let
      dualFnKeysConfig = {
        TIMING = {
          # Press-release within this time range will register as a tap
          TAP_MILLISEC = 200;
          # DISABLE tap action auto-repeat when doing press-release followed by press-and-hold
          DOUBLE_TAP_MILLISEC = 0;
        };
        MAPPINGS = lib.flatten [
          {
            # Caps -> Ctrl/Esc
            KEY = "KEY_CAPSLOCK";
            TAP = "KEY_ESC";
            HOLD = "KEY_LEFTCTRL";
            # NOTE: hold key is immediately pressed, important for Ctrl-MouseEvent to work since
            #   mouse events are NOT routed through this input pipeline.
          }
          {
            # Enter -> Shift/Enter
            # NOTE: for some reason, Shift on Enter key here is never registered by the system 🤔🤔
            KEY = "KEY_ENTER";
            TAP = "KEY_ENTER";
            HOLD = "KEY_RIGHTSHIFT";
            # NOTE: Start pressing Shift just before it is used with another key, this allows me to
            #   use Left or Right shift to send Shift+[tapped]KEY without conflicting with the
            #   default hold action being immediate.
            HOLD_START = "BEFORE_CONSUME";
          }
          {
            # KEY_APOSTROPHE is the key just on the right of my right pinky finger
            # => This replicates on any keyboard the ability I have on my custom split keyboard to
            #    press shift easily (& do easy Ctrl-Shift!)
            # RightOfPinky -> Shift/RightOfPinky
            KEY = "KEY_APOSTROPHE";
            TAP = "KEY_APOSTROPHE";
            HOLD = "KEY_RIGHTSHIFT";
            # NOTE: Start pressing Shift just before it is used with another key, this allows me to
            #   use Left or Right shift to send Shift+[tapped]KEY without conflicting with the
            #   default hold action being immediate.
            HOLD_START = "BEFORE_CONSUME";
          }
          # NOTE: I tried to override OS key to force long tap to not trigger KDE's app launcher
          #   But this doesn't work for me because I need OS key to be pressed early to make
          #   OS-MouseEvent work (for move/resize/..), since mouse events are NOT routed through this
          #   input pipeline.

          # (Block about auto-shifting some keys)
          #
          # FIXME(!!VERY ANNOYING!!): Does not work when rolling keys (called 'key rollover')
          # For example to do `, `
          # I usually roll comma & space keys:
          # - press comma (has auto-shift)
          # - press space
          # - release comma (has auto-shift)
          # - release space
          # BUT this will send ` ,` :/
          # I want other keys to trigger the tap action if this key is pressed
          # => Would need a config like `TAP_START: IN_TAPPING_TERM_OR_BEFORE_OTHER_KEYS`
          # Good issue comment about that:
          #   https://gitlab.com/interception/linux/plugins/dual-function-keys/-/issues/6#note_1087180743
          # And my suggestion for a new mapping config field:
          #   https://gitlab.com/interception/linux/plugins/dual-function-keys/-/issues/6#note_1697883036
          #   Where adding `BEFORE_OTHER_KEY: START_TAP`
          #
          # FIXME: (might be related to keys roll but not sure)
          # To type a `#` on normal azerty, I need to press `AltGr` then the key with `"`.
          # In my config the key `"` is modified to be auto-shifted on hold.
          #   With this config, when I do (within tapping term) a kind of 'key rollover':
          #   ```
          #   keyboard:       AltGr↓   "↓        AltGr↑   "↑
          #   computer sees:  AltGr↓             AltGr↑   "↓"↑
          #   ```
          #   => I get `"`
          #
          #   I want instead:
          #   ```
          #   keyboard:       AltGr↓   "↓        AltGr↑   "↑
          #   computer sees:  AltGr↓   "↓        AltGr↑   "↑
          #   ```
          #   => Would need a config like
          #         `TAP_START: AFTER_PRESS_IF_MODIFIERS`
          #      or `IMMEDIATE_TAP: IF_MODIFIERS`
          #      or `PASSTHROUGH: IF_MODIFIERS` (don't consider as a modified key)
          #
          # (FIXME): No feedback that we're past the tapping term
          # => I don't know when to release the key to get the 'hold' action
          # I'd like the 'hold' action do a tap just after tapping term ended
          # Opened issue: https://gitlab.com/interception/linux/plugins/dual-function-keys/-/issues/46
          #
          # DISABLED FOR NOW
          # (let
          #   autoshiftKey = keyname: {
          #     KEY = keyname;
          #     TAP = keyname;
          #     HOLD = ["KEY_RIGHTSHIFT" keyname];
          #     HOLD_START = "AFTER_RELEASE";
          #   };
          # in [
          #   # Auto-shift some symbol keys on hold
          #   (autoshiftKey "KEY_M")     # `,` key (`?` shifted) on azerty layout
          #   (autoshiftKey "KEY_COMMA") # `;` key (`.` shifted) on azerty layout
          #   (autoshiftKey "KEY_DOT")   # `:` key (`/` shifted) on azerty layout
          #   (autoshiftKey "KEY_EQUAL") # `=` key (`+` shifted) on azerty layout
          #   # Auto-shift number keys on hold
          #   (autoshiftKey "KEY_1")
          #   (autoshiftKey "KEY_2")
          #   (autoshiftKey "KEY_3")
          #   (autoshiftKey "KEY_4")
          #   (autoshiftKey "KEY_5")
          #   (autoshiftKey "KEY_6")
          #   (autoshiftKey "KEY_7")
          #   (autoshiftKey "KEY_8")
          #   (autoshiftKey "KEY_9")
          #   (autoshiftKey "KEY_0")
          #   # WARNING: A bad configuration here can prevent me from entering my root password
          #   #   (In this case, need to reboot and launch previous system generation)
          # ])
        ];
      };
      dualFnKeysInputJob = {
        JOB = inputPipelineJob ["${lib.getExe dual-fn-keys-pkg} -c ${toJsonFile "dual-fn-keys.yaml" dualFnKeysConfig}"];
        DEVICE = {
          EVENTS = {
            # Use this input pipeline for all keyboards with these keys:
            EV_KEY = builtins.map (m: m.KEY) dualFnKeysConfig.MAPPINGS;
          };
        };
      };
    in builtins.toJSON [
      dualFnKeysInputJob
    ];
  };
}
