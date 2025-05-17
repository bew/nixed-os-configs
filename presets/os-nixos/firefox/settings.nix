{
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
    "browser.quitShortcut.disabled" = true; # Disable Ctrl-Q to QUIT all 😬

    # % General UI
    "browser.compactmode.show" = true;
    "ui.key.menuAccessKeyFocuses" = false; # Don't show/focus win menubar on Alt

    # % Tabs
    "browser.tabs.inTitlebar" = 1; # looks nice! ✨
    "browser.tabs.closeWindowWithLastTab" = false; # Don't close window with last closed tab
    "browser.tabs.tabClipWidth" = 999; # only the active tab has a close button
    "browser.tabs.tabMinWidth" = 100; # Larger min tab size, helps with tab selection when the 'mute-sound' button is visible
    "browser.tabs.groups.enabled" = true; # Tab groups!
    "browser.tabs.fadeOutExplicitlyUnloadedTabs" = true;

    # % URL bar
    "network.IDN_show_punycode" = true; # Show punycode (normalized unicode chars, to avoid bad phishing attempts)
    "browser.urlbar.quickactions.enabled" = true; # Type `>` then space, to see available quickactions
    # ref: https://github.com/mozilla-firefox/firefox/tree/b0360425521158ab/browser/components/urlbar/unitconverters/
    "browser.urlbar.unitConversion.enabled" = true; # Show unit conversion result (some, see ref 👆)
    "browser.urlbar.suggest.calculator" = true; # Show simple calculator result

    # % Bookmarks
    "browser.bookmarks.defaultLocation" = "menu"; # (not `toolbar`)
    "browser.bookmarks.openInTabClosesMenu" = false; # Don't close bmark menu on Ctrl-click, middle-click, etc…
    "browser.bookmarks.showOtherBookmarks" = false; # When bookmark bar is visible, don't show 'Other bookmarks' on the far right
    "browser.toolbars.bookmarks.visibility" = "never"; # newtab|always|never

    # % Page interactions
    # Don't autostart quick find bar when typing (still opens on `/` or `'`(links only))
    "accessibility.typeaheadfind.autostart" = false;
    "findbar.highlightAll" = true; # Highlight all matches
    # Don't select space after word when double-clicking to select words
    # (this is the default on Linux, but it's good to have it here for reference!)
    "layout.word_select.eat_space_to_next_word" = false;
    # % Page Scrolling
    "general.autoScroll" = true; # Allow fast scroll with middle-mouse-button
    "mousewheel.with_alt.action" = 5; # Alt-scroll will zoom in/out (pinch zoom, like on phone)
    # % Page Content
    "reader.parse-on-load.force-enabled" = true; # Keep the reader button enabled at all times

    "devtools.editor.keymap" = "vim"; # 👀

    # % Disable few useless stuff..
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
