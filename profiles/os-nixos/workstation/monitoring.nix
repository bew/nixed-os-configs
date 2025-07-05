{
  # Let's monitor my PC!

  # NOTE: using my own `netdata-oss` service module to use netdata v1
  #   (v1 _still_ has the local Web UI, but v2 is cloud-only)

  services.netdata-oss.enable = true;
  # NOTE: easily check current config at <http://localhost:19999/netdata.conf>

  services.netdata-oss.config = {
    # Enable more metrics around power supply
    "plugin:proc:/sys/class/power_supply" = {
      "battery capacity" = "yes"; # the default
      "battery charge" = "yes";
      "battery energy" = "yes";
      "power supply voltage" = "yes";
    };
  };
}
