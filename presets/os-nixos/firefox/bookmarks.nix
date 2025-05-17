{
  # doc: https://mozilla.github.io/policy-templates/#bookmarks
  programs.firefox.policies.ManagedBookmarks = [
    # Firefox UI
    {
      name = "FF Library";
      url = "chrome://browser/content/places/places.xhtml";
      # MANUAL-CONFIG: Set `keyword` to `bmarks` or `fflib` 🤔
    }

    # Websites
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
      name = "My dotfiles!";
      url = "https://github.com/bew/dotfiles";
      # MANUAL-CONFIG: Set `keyword` to `gd`
    }
    {
      name = "Nixpkgs repo";
      url = "https://github.com/NixOS/nixpkgs";
      # MANUAL-CONFIG: Set `keyword` to `nxp`
    }
    {
      name = "Nix search NixOS options";
      url = "https://search.nixos.org/options";
      # MANUAL-CONFIG: Set `keyword` to `nso`
    }
    {
      name = "Nix search packages";
      url = "https://search.nixos.org/packages";
      # MANUAL-CONFIG: Set `keyword` to `nsp`
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
      name = "Python3 std";
      url = "https://docs.python.org/3/library/index.html";
      # MANUAL-CONFIG: Set `keyword` to `pyd`
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
    {
      name = "GKeep"; # my current note-taking app
      url = "https://keep.google.com";
      # MANUAL-CONFIG: Set `keyword` to `kp`
    }
  ];
}
