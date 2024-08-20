{ lib, config, ... }:

{
  options = {
    testModule.enable = lib.mkEnableOption "Enable test";
  };
  config = lib.mkIf config.testModule.enable {
    home.file."TESTFILE" = {
      enable = true;
      text = "AAAAAA";
    };
  };
}
