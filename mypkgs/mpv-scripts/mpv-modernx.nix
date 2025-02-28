{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:

stdenvNoCC.mkDerivation rec {
  pname = "mpv-modernx";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "cyl0";
    repo = "ModernX";
    rev = version;
    hash = "sha256-q7DwyfmOIM7K1L7vvCpq1EM0RVpt9E/drhAa9rLYb1k=";
  };

  dontBuild = true;
  installPhase = ''
    install -D -t $out/share/mpv/scripts  modernx.lua
    install -D -t $out/share/mpv/fonts    Material-Design-Iconic-Font.ttf
  '';
  passthru.scriptName = "modernx.lua";

  meta = with lib; {
    description = "A modern OSC UI replacement for MPV that retains the functionality of the default OSC.";
    homepage = "https://github.com/cyl0/ModernX";
    license = licenses.unlicense;
    platforms = platforms.all;
    maintainers = with maintainers; [ bew ];
  };
}
