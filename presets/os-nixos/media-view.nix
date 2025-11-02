{ pkgsets, ... }:

let inherit (pkgsets) stable mypkgs; in

{
  environment.systemPackages = [
    stable.nomacs

    (mypkgs.mpvConfigurable  {
      disableDefaultUI = true;
      plugins = [
        mypkgs.mpvScripts.undoredo
        mypkgs.mpvScripts.thumbfast
        mypkgs.mpvScripts.copyTime
        mypkgs.mpvScripts.modernx # UI plugin

        # mypkgs.mpvScripts.uosc # UI plugin
        # note: uosc can do many things, but is a little bloated, and doesn't show actual playlist..
        #   proximity and UI animations aren't my thing…
      ];
    })
  ];
}
