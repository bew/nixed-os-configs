# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/for-zsa-keyboards.nix
    ../../modules/better-nix-settings.nix
    # Disable the KDE file indexer `baloo`, when I add/delete/change a lot of small files
    # (e.g: when cloning / compressing / deleting the nixpkgs repo) baloo seems to update
    # its cache like crazy by writing 100M/s on the disk for many minutes (10-15?)...
    # And I actually never use file search that needs pre-indexing, so bye bye o/
    ../../modules/disable-kde-file-indexer.nix
  ];

  # IDEA: 'options' that act as hardware reference, to be able to access the hardware info in a pure way at eval time,
  # to allow writing this option relative to hardware info:
  # nix.settings.cores = config.hardware-reference.cpuCount / 2;
  nix.settings.cores = 8;

  nix.gc = {
    automatic = true; # Let's try!
    dates = "weekly";
    # NOTE: Ideally I'd like to keep at least the last N known-to-work configs
    # See related notes in 20220919T2145 to tag working config.
    options = "--delete-old --delete-older-than 30d";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmpOnTmpfs = true;
  boot.tmpOnTmpfsSize = "4G";

  networking.hostName = "frametop";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = let
    nativeLang = "fr_FR.UTF-8";
  in {
    LC_MEASUREMENT = nativeLang;
    LC_MONETARY = nativeLang;
    LC_NUMERIC = nativeLang;
    LC_PAPER = nativeLang;
    LC_TELEPHONE = nativeLang;
    LC_TIME = nativeLang;
    # NOTE: `LC_ALL` should only be set for troubleshooting, it overrides every
    # local settings, can be set to C.UTF-8 for simple debugs (while still
    # supporting unicode chars).
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions for keymap in tty
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "fr";
  services.xserver.xkbOptions = "caps:escape"; # map caps to escape.

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad = {
    # FIXME: Is there a way to configure the timeout until the touchpad is re-enabled again?
    #   Or a way to disable taps for a bit longer? (drag is not an issue)
    # On the Framework, the touchpad is BIG, and not exactly centered w.r.t. `f` & `j` keys,
    # and when I type, the internal edge of my right palm is actually over the touchpad.
    # => It happens too often that I tap the touchpad with it by mistake,
    #    moving the cursor to unwanted / surprising locations..
    # Disabling mouse action in vim's insert mode is not enough,
    # it also happens on normal mode, and can be destructive!
    #
    # Upstream feature request issues:
    # - https://gitlab.freedesktop.org/libinput/libinput/-/issues/379
    # - https://gitlab.freedesktop.org/libinput/libinput/-/issues/619
    disableWhileTyping = true;

    tappingDragLock = false; # It's just annoying to have it and be surprised when doing fast movements..
    additionalOptions = ''
      # Tapping with 1/2/3 fingers give left/middle/right buttons respectively
      # Ref: https://wiki.archlinux.org/title/libinput#Tapping_button_re-mapping
      Option "TappingButtonMap" "lmr"
    '';
  };

  # interception-tools' pipeline can be very flexible
  # doc: https://gitlab.com/interception/linux/tools
  services.interception-tools = {
    enable = true;
    plugins = [pkgs.interception-tools-plugins.caps2esc];
    # For some reason PATH isn't passed to job specified in the config
    # This is tracked in these issues:
    # - https://github.com/NixOS/nixpkgs/issues/126681
    # - https://gitlab.com/interception/linux/tools/-/issues/58
    # So we specify full path to the various tools in config for now.
    udevmonConfig = let
      caps2esc = pkgs.interception-tools-plugins.caps2esc;
      interception-tools = pkgs.interception-tools;
    in /* yaml */ ''
      # note on caps2esc usage:
      # -m 1 : minimal mode: caps as esc/ctrl
      - JOB: "${interception-tools}/bin/intercept -g $DEVNODE | ${caps2esc}/bin/caps2esc -m 1 | ${interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK]
    '';
    # NOTE: `-t` didn't do what I thought, it's not the held-timeout behavior I want,
    #   it's just the time generated keys are held (20 micro-seconds by default (=> 0.02s or 20ms))
    #
    # TODO: port `caps2esc` to Rust, and implement held-timeout behavior!
    # * (?) Rename to caps2ctrlesc
    # * Support mouse inputs, as documented at:
    #   https://gitlab.com/interception/linux/plugins/caps2esc#mousetouchpad-support
    #   => Allows Ctrl-click to work with held caps key!
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;  # Disabled, pipewire config should take care of this
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # FIXME: When connecting to an HDMI monitor (over USB-C hub, didn't test without),
    # the HDMI audio profile is not activated by default.
    # When I activate it, and later disconnect the monitor, the audio doesn't auto switch
    # back to `Analog Stereo Duplex`.
    #
    # This issue was mentionned in NixOS's Tracking issue for pipewire:
    # https://github.com/NixOS/nixpkgs/issues/102547#issuecomment-1277892311
    # (with next comments giving some info, not tried yet)
    #
    # Upstream issues that might be related: (I subscribed to them)
    # - https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2545
    # - https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2951
  };

  services.flatpak.enable = true;

  programs.kdeconnect.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bew = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable *sudo* for the user.
    packages = with pkgs; [
      firefox
      kdenlive
    ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim # at the very least
    wget
    file
    git
    zip
    unzip
    ark # a nice archive gui, usually used in KDE
    _7zz # 7z (not sure why the drv is named that way...)

    gparted
    ntfs3g

    appimage-run # to easily run downloaded appimage files

    # Install with the system to ensure the same qt version is used,
    # to avoid error on start.
    # See <20230328T1209#incompatible-qt>
    transmission-qt
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest; # TODO: pin?

  # This will regularly tell the SSD which blocks are deleted on the filesystem side,
  # so these blocks can be used for other things by the SSD controller.
  # => Helps SSD performance & lifespan!
  # See: https://en.wikipedia.org/wiki/Trim_(computing)
  services.fstrim.enable = true; # Runs weekly

  # Let's monitor my PC!
  # TODO(later): send metrics to some external server? cloud service?
  #   and monitor some things?
  services.netdata.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
