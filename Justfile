deploy:
  nixos-rebuild switch --flake .

debug:
  nixos-rebuild switch --flake . --show-trace --verbose

up:
  nix flake update

# Update specific input
# usage: make upi i=home-manager
upi:
  nix flake update $(i)

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  sudo nix-collect-garbage --delete-old 

# dnsc-air
mac-re:
  darwin-rebuild switch --flake .

mac-up:
  darwin-rebuild switch --recreate-lock-file --flake . && brew upgrade && brew upgrade --cask --greedy

# dnsc-deck
deck-re:
  nix run home-manager/master -- switch flake .#dnsc-deck
