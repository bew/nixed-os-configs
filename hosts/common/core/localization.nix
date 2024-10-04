{
  time.timeZone = "Europe/Paris";

  # Text messages and default language should be English,
  # but all other region-specific formatting should be for my native language.
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

  # Safe to set all-the-time even if xserver not actually used.
  services.xserver.layout = "fr";
}
