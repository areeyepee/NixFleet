# ============================================================================
# FLEET HOST DEFINITIONS
# Single source of truth for all host information
# ============================================================================

{

  main = {
    ip = "192.168.2.213";
    user = "areeyepee";
    tags = [
      
    ];
  }
  alpha = {
    ip = "192.168.122.55";
    user = "logan";
    tags = [
      "control-plane"
      "monitoring"
    ];
  };

  bravo = {
    ip = "192.168.122.112";
    user = "logan";
    tags = [
      "git"
    ];
  };

  charlie = {
    ip = "192.168.122.187";
    user = "logan";
    tags = [ ];
  };
}
