{ stdenv, fetchurl, pkgconfig, glib, python3, systemd, libgudev }:

stdenv.mkDerivation rec {
  pname = "libmbim";
  version = "1.22.0";

  src = fetchurl {
    url = "https://www.freedesktop.org/software/libmbim/${pname}-${version}.tar.xz";
    sha256 = "0f0zmbvnhdsqbf3hw5bimq67n57mhd8yad1ia823cb6i3kmph1sw";
  };

  outputs = [ "out" "dev" "man" ];

  configureFlags = [
    "--with-udev-base-dir=${placeholder "out"}/lib/udev"
  ];

  nativeBuildInputs = [
    pkgconfig
    python3
  ];

  buildInputs = [
    glib
    libgudev
    systemd
  ];

  doCheck = true;

  meta = with stdenv.lib; {
    homepage = "https://www.freedesktop.org/wiki/Software/libmbim/";
    description = "Library for talking to WWAN modems and devices which speak the Mobile Interface Broadband Model (MBIM) protocol";
    platforms = platforms.linux;
    license = licenses.gpl2;
  };
}
