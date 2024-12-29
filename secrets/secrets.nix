let
  viruz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEoxeBCvP4D+MaU44pHL0lIv1sy65HaNAvQZ+Ok6kShX viruz@mimi";

  mimi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7k8jW8T4hhPkVs1Z4cH4J/MdcRuM1Bsi/DnTjdy7pu root@mimi";
in {
  "tailscale.age".publicKeys = [viruz mimi];
  "weatherapi.age".publicKeys = [viruz mimi];
}
