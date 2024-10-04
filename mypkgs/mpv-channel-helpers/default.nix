{
  runCommandLocal,
  lib,

  jo,
  socat,
  mpv ? "from-PATH",
  jq,
}:

runCommandLocal "@mpv" { meta.mainProgram = "@mpv"; } /* sh */ ''
  mkdir -p $out/bin
  substitute ${./mpv-helpers.sh} $out/bin/@mpv \
    ${if mpv == "from-PATH"
      then ""
      else '' --replace "_BIN_mpv=" "_BIN_mpv=${lib.getExe mpv} #" ''
    } \
    --replace "_BIN_socat=" "_BIN_socat=${lib.getExe socat} #" \
    --replace "_BIN_jq=" "_BIN_jq=${lib.getExe jq} #" \
    --replace "_BIN_jo=" "_BIN_jo=${lib.getExe jo} #"
  chmod +x $out/bin/@mpv
''
