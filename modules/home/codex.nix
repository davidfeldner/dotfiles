_: {
  flake.modules.homeManager.codex = _: {
    programs.mcp = {
      enable = true;
      servers.ghidra = {
        command = "/home/david/ghidraMCP/.venv/bin/python";
        args = [
          "/home/david/ghidraMCP/bridge_mcp_ghidra.py"
          "--ghidra-server"
          "http://127.0.0.1:8080/"
        ];
      };
    };

    programs.codex = {
      enable = true;
      enableMcpIntegration = true;
      settings = {
        projects = {
          "/home/david/nixos".trust_level = "trusted";
          "/home/david/ghidraMCP".trust_level = "trusted";
        };
        tui.model_availability_nux."gpt-5.5" = 4;
      };
    };
  };
}
