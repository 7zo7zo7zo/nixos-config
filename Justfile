ROOT_DIR := `git rev-parse --show-toplevel`
HOST := `hostname`

switch:
	sudo nixos-rebuild switch --flake {{ROOT_DIR}}#{{HOST}}

gc:
	sudo nix-collect-garbage --delete-old

write-flake:
	nix run {{ROOT_DIR}}#write-flake
