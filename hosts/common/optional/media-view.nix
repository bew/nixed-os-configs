{ pkgs, myPkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nomacs

    (myPkgs.mpvConfigurable  {
      disableDefaultUI = true;
      plugins = [
        myPkgs.mpvScripts.undoredo
        myPkgs.mpvScripts.thumbfast
        myPkgs.mpvScripts.copyTime
        myPkgs.mpvScripts.modernx # UI plugin

        # myPkgs.mpvScripts.uosc # UI plugin
        # note: uosc can do many things, but is a little bloated, and doesn't show actual playlist..
        #   proximity and UI animations aren't my thing…
      ];
    })
  ];
}
