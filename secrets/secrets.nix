let
  viruz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEoxeBCvP4D+MaU44pHL0lIv1sy65HaNAvQZ+Ok6kShX";

  # mimi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7k8jW8T4hhPkVs1Z4cH4J/MdcRuM1Bsi/DnTjdy7pu";
  mimi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKWRTuKTAw4d8FEPpOiYSVVlykuTMo48HArkH+73Do4j";
in {
  "tailscale.age".publicKeys = [viruz mimi];
  "kuroneko.age".publicKeys = [viruz mimi];
  # "github.age".publicKeys = [viruz mimi];
  "deluge.age".publicKeys = [viruz mimi];
}
