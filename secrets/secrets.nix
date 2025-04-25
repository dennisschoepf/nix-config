let
  dnsc-air = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvXWZOPOJJDAoF+Sx/ZLoAVu6G/7/MAWoknBgMAzjul dennis@dnsc-mac";
  dnsc-vps-sm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHHS4Cq3G0yjoXB9qargJc/zbZdlClnJOcLxSC5ROo7h dennis@dnsc-vps-sm";
  dnsc-server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM3mkEgvHrwjsEReHQHpLbMP71JLvp6XxMPyW7PTaLCd dennis@dnsc-server";
  systems = [ dnsc-air dnsc-vps-sm dnsc-server ];
in
{
  # Add like this: "secret1.age".publicKeys = systems;
  "vaultwarden/env.age".publicKeys = systems;
}

# 1. Create a file with secret
# nix run github:ryantm/agenix -- -e $FILE_PATH
#
# 2. Reference the file in NixOS config:
# {
#  age.secrets.secret1.file = ../secrets/secret1.age;
# }
#
# 3. And use it like this:
# passwordFile = config.age.secrets.secret1.path;

