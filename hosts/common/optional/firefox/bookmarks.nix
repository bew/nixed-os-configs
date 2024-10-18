{
  # doc: https://mozilla.github.io/policy-templates/#bookmarks
  programs.firefox.policies.ManagedBookmarks = [
    {
      name = "Github";
      url = "https://github.com";
      # MANUAL-CONFIG: Set `keyword` to `gh`
    }
    {
      name = "Github Notifications";
      url = "https://github.com/notifications";
      # MANUAL-CONFIG: Set `keyword` to `gn`
    }
    {
      name = "LibreTranslate";
      url = "https://libretranslate.com";
      # MANUAL-CONFIG: Set `keyword` to `tr`
    }
    {
      name = "Perplexity";
      url = "https://perplexity.ai";
      # MANUAL-CONFIG: Set `keyword` to `px`
    }
    {
      name = "Rust std";
      url = "https://doc.rust-lang.org/std/index.html";
      # MANUAL-CONFIG: Set `keyword` to `rsd`
    }
    {
      name = "Rust Libs";
      url = "https://lib.rs/";
      # MANUAL-CONFIG: Set `keyword` to `rsl`
    }
    {
      name = "MonkeyType";
      url = "https://monkeytype.com";
      # MANUAL-CONFIG: Set `keyword` to `mtype`
    }
    {
      name = "Discord Web";
      url = "https://discord.com/app";
      # MANUAL-CONFIG: Set `keyword` to `disc`
    }
  ];
}
