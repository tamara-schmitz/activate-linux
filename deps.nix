{ pkgs }:
with pkgs; [
	cairo
	xorg.libXi
	xorg.libX11
	xorg.xorgproto
	xorg.libXt
	xorg.libXfixes
	xorg.libXinerama
	xorg.libXrandr
	wayland
	wayland-protocols
]
