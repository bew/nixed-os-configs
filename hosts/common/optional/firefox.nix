{
  programs.firefox.enable = true;

  programs.firefox.languagePacks = [ "en-US" "fr" ];

  # My NixOS-set prefs will appear as the default ✨
  programs.firefox.preferencesStatus = "default";

  # Inspirations:
  # - https://www.reddit.com/r/firefox/comments/17hlkhp/what_are_your_must_have_changes_in_aboutconfig/
  # - https://github.com/loganmarchione/Firefox-tweaks/blob/master/user.js
  #
  # Refs: (can't find a single file with ALL prefs…)
  # - https://searchfox.org/mozilla-release/source/browser/app/profile/firefox.js
  # - https://searchfox.org/mozilla-release/source/modules/libpref/init/all.js
  # - https://searchfox.org/mozilla-release/source/modules/libpref/init/StaticPrefList.yaml
  programs.firefox.preferences = {
    "ui.key.menuAccessKeyFocuses" = false; # Don't show/focus win menubar on Alt
    "browser.quitShortcut.disabled" = true; # Disable Ctrl-Q to QUIT all 👀

    "browser.tabs.inTitlebar" = 1; # looks nice!
    "browser.tabs.closeWindowWithLastTab" = false; # Don't close window with last closed tab
    "browser.tabs.tabClipWidth" = 999; # only the active tab has a close button
    "browser.compactmode.show" = true;

    "network.IDN_show_punycode" = true; # Show punycode (normalized unicode chars, to avoid bad phishing attempts)
    "browser.urlbar.quickactions.enabled" = true; # Type `>` then space, to see available quickactions

    "reader.parse-on-load.force-enabled" = true; # Keep the reader button enabled at all times

    # Don't autostart quick find bar when typing (would still open on `/` or `'`(links only))
    "accessibility.typeaheadfind.autostart" = false;
    "findbar.highlightAll" = true; # Highlight all matches

    # Don't select space after word when double-clicking to select words
    # (this is the default on Linux, but it's good to have it here for reference!)
    "layout.word_select.eat_space_to_next_word" = false;

    "general.autoScroll" = true; # Allow fast scroll with middle-mouse-button
    "mousewheel.with_alt.action" = 5; # Alt-scroll will zoom in/out (pinch zoom, like on phone)

    "browser.vpn_promo.enabled" = false; # No promo please…
    "browser.newtabpage.activity-stream.default.sites" = ""; # Clear default TopSites
  };

  # doc: https://mozilla.github.io/policy-templates/
  programs.firefox.policies = {
    # Remove the “Set As Desktop Background…” menuitem when right clicking on an image.
    DisableSetDesktopBackground = true;

    # Disable most sections of the Firefox Home page.
    FirefoxHome = {
      Search = true;
      TopSites = false;
      SponsoredTopSites = false;
      Highlights = false;
      Pocket = false;
      SponsoredPocket = false;
      Snippets = false;
      Locked = false;
    };

    # Tweak when Firefox messages the user (me) in certain situations
    UserMessaging = {
      FirefoxLabs = true;
      UrlbarInterventions = true;
      FeatureRecommendations = true; # 🤔
      Locked = false;
      # Block
      ExtensionRecommendations = false;
      SkipOnboarding = true;
      MoreFromMozilla = false;
    };

    # Disable creation of default bookmarks (for new profiles).
    NoDefaultBookmarks = true;

    # Don't suggest to save password (I use my own passwd manager)
    PasswordManagerEnabled = false;
    OfferToSaveLogins = false;

    # Disable auto-playing audio
    Permissions.AutoPlay.Default = "block-audio";

    # Disable pop-up window by default
    PopupBlocking.Default = false;

    # Protect me against tracking
    EnableTrackingProtection = {
      Value = true;
      Locked = false;
      Cryptomining = true;
      Fingerprinting = true;
    };
  };
}
