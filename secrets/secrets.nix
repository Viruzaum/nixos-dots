let
  viruz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEoxeBCvP4D+MaU44pHL0lIv1sy65HaNAvQZ+Ok6kShX";

  mimi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKWRTuKTAw4d8FEPpOiYSVVlykuTMo48HArkH+73Do4j";
  yun = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICUjzI6ksfksTSmdxg6SS+MaryygbSe7g22ltnFOGB0F viruz@yun";
in {
  "tailscale.age".publicKeys = [viruz mimi yun];
  "kuroneko.age".publicKeys = [viruz mimi];
}
