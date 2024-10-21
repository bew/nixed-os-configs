{
  # Let's monitor my PC!
  services.netdata.enable = true;
  # NOTE: easily check current config at <http://localhost:19999/netdata.conf>
  services.netdata.config = {
    # Enable more metrics around power supply
    "plugin:proc:/sys/class/power_supply" = {
      "battery capacity" = "yes"; # the default
      "battery charge" = "yes";
      "battery energy" = "yes";
      "power supply voltage" = "yes";
    };
  };
}
