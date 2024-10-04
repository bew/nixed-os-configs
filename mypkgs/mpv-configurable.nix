{
  mpv-unwrapped,
  makeWrapper,

  buildEnv,

  lib,
}:

# NOTE: The builtin wrapper `mpv.override` basically only allows to set `--script=...` repeatedly,
# but does not support other configurations like input, font, options, nor plugins that have specific fonts..
{
  disableDefaultUI ? false,
  plugins ? [],
}:
let
  # ref: https://mpv.io/manual/stable/#files
  mpv-home-dir = buildEnv {
    name = "mpv-home";
    pathsToLink = [ "/share/mpv" ];
    paths = plugins;
  };
in buildEnv {
  name = "configured-mpv";
  meta.mainProgram = "mpv";
  paths = [ mpv-unwrapped ];
  nativeBuildInputs = [ makeWrapper ];
  # Setup the binary to point to dir with plugins
  postBuild = /* sh */ ''
    rm $out/bin # remove default bin
    mkdir $out/bin

    makeWrapper ${lib.getExe mpv-unwrapped} $out/bin/mpv \
      --set MPV_HOME ${mpv-home-dir}/share/mpv \
      ${if disableDefaultUI then "--add-flags '--no-osc'" else ""}
  '';
}
