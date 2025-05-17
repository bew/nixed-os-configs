{
  imports = [
    ./bookmarks.nix
    ./settings.nix
    ./extensions.nix
  ];

  programs.firefox.enable = true;

  programs.firefox.languagePacks = [ "en-US" "fr" ];

  # Use XInput2 on X11 to support modern _precise_ touchpad gestures
  # (like 2-fingers swipe for backward/forward history & pinch-to-zoom)
  # REF: https://bugzilla.mozilla.org/show_bug.cgi?id=1539730
  environment.sessionVariables.MOZ_USE_XINPUT2 = "1";
}
