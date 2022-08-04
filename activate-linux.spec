Summary: The "Activate Windows" watermark ported to Linux
Version: 0.2
License: GPL-3.0-only
Name: activate-linux
Release: 1
Group: System/GUI/Other
Source: activate-linux-%{version}.tar.gz
URL: https://github.com/MrGlockenspiel/activate-linux
Buildroot: /tmp/activate-linux-git
BuildRequires: clang cairo-devel
BuildRequires: libXi-devel libX11-devel libXrandr-devel libXt-devel libXinerama-devel
BuildRequires: wayland-devel
BuildRequires: pandoc

%if 0%{?suse_version}
BuildRequires: xcb-proto-devel
%endif

%if 0%{?fedora} || 0%{?rhel_version} || 0%{?centos_version}
BuildRequires: glibc-all-langpacks
%endif

%description
The "Activate Windows" watermark ported to Linux with Xlib and cairo in C

"Science isn't about WHY. It's about WHY NOT. Why is so much of our science dangerous? Why not marry safe science if you love it so much. In fact, why not invent a special safety door that won't hit you on the butt on the way out, because you are fired."

Maintained by MrGlockenspiel.

%prep
%setup -q
export PREFIX=""
export BINDIR="%{_bindir}"
export MANDIR="%{_mandir}"

%build
export CFLAGS="%{optflags}"
%make_build

%install
%make_install

%files
%{_bindir}/activate-linux
%{_mandir}/man1/activate-linux.1.gz
%license LICENSE.md
%doc ARGS.md README.md
