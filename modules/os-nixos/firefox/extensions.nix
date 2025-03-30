{ pkgs, ... }:

let
  latestUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
in {
  programs.firefox.nativeMessagingHosts.packages = [
    pkgs.tridactyl-native
  ];

  # IDEA: try ff2mpv 🤔
  #   https://github.com/woodruffw/ff2mpv
  # programs.firefox.nativeMessagingHosts.ff2mpv = true;

  # Find Extension ID in <about:support>.
  # Doc: https://mozilla.github.io/policy-templates/#extensionsettings
  programs.firefox.policies.ExtensionSettings = {
    "*" = {
      installation_mode = "normal_installed";
    };

    # --- General extensions

    # uBlock - https://ublockorigin.com/
    "uBlock0@raymondhill.net" = {
      install_url = latestUrl "ublock-origin";
    };

    # BitWarden
    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
      install_url = latestUrl "bitwarden-password-manager";
    };

    # Tridactyl
    "tridactyl.vim@cmcaine.co.uk" = {
      install_url = latestUrl "tridactyl-vim";
    };

    # Tab Session Manager
    "Tab-Session-Manager@sienori" = {
      install_url = latestUrl "tab-session-manager";
    };

    # Copy Selected Tabs to Clipboard
    "copy-selected-tabs-to-clipboard@piro.sakura.ne.jp" = {
      install_url = latestUrl "copy-selected-tabs-to-clipboar"; # yes last `d` is missing
    };

    # --- Website-specific extensions

    # Github Refined
    "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
      install_url = latestUrl "refined-github-"; # yes it ends with `-`
    };
    # Notifications Preview for GitHub
    # NOTE: must be manually configured to:
    #   - hide 'Mark all as read'
    #   - auto-hide when mouse quits area
    "notifications-preview-github@tanmayrajani.github.io" = {
      latestUrl = latestUrl "notifications-preview-github";
    };

    # Unhook - https://unhook.app/ ((!!) not opensource :/)
    # NOTE: must be manually configured to hide different parts of the YouTube UI.
    #   -> Disable:
    #    - Hide Home Feed
    #    - Hide Recommended (video recommendations)
    #    - Hide Playlist
    #    - Hide Top Header (want my few notifications!)
    #   -> Enable:
    #    + Hide Shorts
    #    + Hide Mixes
    #    + Hide Explore, Trending
    "myallychou@gmail.com" = {
      install_url = latestUrl "youtube-recommended-videos";
    };
    # DeArrow - https://dearrow.ajay.app/
    "deArrow@ajay.app" = {
      install_url = latestUrl "dearrow";
    };
    # SponsorBlock - https://sponsor.ajay.app/
    "sponsorBlocker@ajay.app" = {
      install_url = latestUrl "sponsorblock";
    };
    # YouTube search engine
    "{2a168bd0-55d2-466f-9c68-077c416943be}" = {
      install_url = latestUrl "youtube-search-engine";
    };

    # Rust Search Extension
    "{04188724-64d3-497b-a4fd-7caffe6eab29}" = {
      install_url = latestUrl "rust-search-extension";
    };
  };
}
