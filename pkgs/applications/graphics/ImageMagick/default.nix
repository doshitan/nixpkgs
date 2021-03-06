{ stdenv, fetchurl, pkgconfig, libtool
, libcl ? null, perl ? null, jemalloc ? null, bzip2 ? null, zlib ? null
, libX11 ? null, libXext ? null, libXt ? null, dejavu_fonts ? null, fftw ? null
, libfpx ? null, djvulibre ? null, fontconfig ? null, freetype ? null
, ghostscript ? null, graphviz ? null, jbigkit ? null, libjpeg ? null
, lcms2 ? null, openjpeg ? null, liblqr1 ? null, xz ? null, openexr ? null
, pango ? null, libpng ? null, librsvg ? null, libtiff ? null, libwebp ? null
, libxml2 ? null
}:

let

  version = "6.9.1-0";

  arch =
    if stdenv.system == "i686-linux" then "i686"
    else if stdenv.system == "x86_64-linux" || stdenv.system == "x86_64-darwin" then "x86-64"
    else throw "ImageMagick is not supported on this platform.";

  hasX11 = libX11 != null && libXext != null && libXt != null;

in

with stdenv.lib;
stdenv.mkDerivation rec {
  name = "imagemagick-${version}";

  src = fetchurl {
    url = "mirror://imagemagick/releases/ImageMagick-${version}.tar.xz";
    sha256 = "03lvj6rxv16xk0dpsbzvm2gq5bggkwff9wqbpkq0znihzijpax1j";
  };

  enableParallelBuilding = true;

  configureFlags = [
    (mkEnable (libcl != null)        "opencl"      null)
    (mkWith   true                   "modules"     null)
    (mkWith   true                   "gcc-arch"    arch)
    #(mkEnable true                   "hdri"        null) This breaks some dependencies
    (mkWith   (perl != null)         "perl"        null)
    (mkWith   (jemalloc != null)     "jemalloc"    null)
    (mkWith   true                   "frozenpaths" null)
    (mkWith   (bzip2 != null)        "bzlib"       null)
    (mkWith   hasX11                 "x"           null)
    (mkWith   (zlib != null)         "zlib"        null)
    (mkWith   false                  "dps"         null)
    (mkWith   (fftw != null)         "fftw"        null)
    (mkWith   (libfpx != null)       "fpx"         null)
    (mkWith   (djvulibre != null)    "djvu"        null)
    (mkWith   (fontconfig != null)   "fontconfig"  null)
    (mkWith   (freetype != null)     "freetype"    null)
    (mkWith   (ghostscript != null)  "gslib"       null)
    (mkWith   (graphviz != null)     "gvc"         null)
    (mkWith   (jbigkit != null)      "jbig"        null)
    (mkWith   (libjpeg != null)      "jpeg"        null)
    (mkWith   (lcms2 != null)        "lcms2"       null)
    (mkWith   false                  "lcms"        null)
    (mkWith   (openjpeg != null)     "openjp2"     null)
    (mkWith   (liblqr1 != null)      "lqr"         null)
    (mkWith   (xz != null)           "lzma"        null)
    (mkWith   (openexr != null)      "openexr"     null)
    (mkWith   (pango != null)        "pango"       null)
    (mkWith   (libpng != null)       "png"         null)
    (mkWith   (librsvg != null)      "rsvg"        null)
    (mkWith   (libtiff != null)      "tiff"        null)
    (mkWith   (libwebp != null)      "webp"        null)
    (mkWith   (libxml2 != null)      "xml"         null)
  ] ++ optional (dejavu_fonts != null) "--with-dejavu-font-dir=${dejavu_fonts}/share/fonts/truetype/"
    ++ optional (ghostscript != null) "--with-gs-font-dir=${ghostscript}/share/ghostscript/fonts/";

  buildInputs = [
    pkgconfig libtool libcl perl jemalloc bzip2 zlib libX11 libXext libXt fftw
    libfpx djvulibre fontconfig freetype ghostscript graphviz jbigkit libjpeg
    lcms2 openjpeg liblqr1 xz openexr pango libpng librsvg libtiff libwebp
    libxml2
  ];

  propagatedBuildInputs = []
    ++ (stdenv.lib.optional (lcms2 != null) lcms2)
    ++ (stdenv.lib.optional (liblqr1 != null) liblqr1)
    ++ (stdenv.lib.optional (fftw != null) fftw)
    ++ (stdenv.lib.optional (libtool != null) libtool)
    ++ (stdenv.lib.optional (jemalloc != null) jemalloc)
    ++ (stdenv.lib.optional (libXext != null) libXext)
    ++ (stdenv.lib.optional (libX11 != null) libX11)
    ++ (stdenv.lib.optional (libXt != null) libXt)
    ++ (stdenv.lib.optional (bzip2 != null) bzip2)
    ;

  postInstall = ''(cd "$out/include" && ln -s ImageMagick* ImageMagick)'';

  meta = with stdenv.lib; {
    homepage = http://www.imagemagick.org/;
    description = "A software suite to create, edit, compose, or convert bitmap images";
    platforms = platforms.linux ++ [ "x86_64-darwin" ];
    maintainers = with maintainers; [ the-kenny wkennington ];
  };
}
