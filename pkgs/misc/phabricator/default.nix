{ stdenv, fetchFromGitHub, pkgs, ...  }:

stdenv.mkDerivation rec {
  version = "2014-07-16";
  name = "phabricator-${version}";
  srcLibphutil = fetchFromGitHub {
    owner = "phacility";
    repo = "libphutil";
    rev = "48a04395363d6c1dd9f66057bd11fd70d4665ba9";
    sha256 = "d570d2c1e68471c2eda35b8722d8083bcc13163fbd5c944529464f2c7b55a2e5";
  };
  srcArcanist = fetchFromGitHub {
    owner = "phacility";
    repo = "arcanist";
    rev = "97501da16416fbfdc6e84bd60abcbf5ad9506225";
    sha256 = "9031c4ae228bdc986131e0c93c98fb73290bb0e297be1ec32f22ab09cdacafa3";
  };
  srcPhabricator = fetchFromGitHub {
    owner = "phacility";
    repo = "phabricator";
    rev = "7ac5abb97934f7399b67762aa98f59f667711bf3";
    sha256 = "6a1d449597ae4432e40a3e6cdb14e3a5a8a40e019f3930493064c35911f2adcc";
  };

  buildCommand = ''
    mkdir -p $out
    cp -R ${srcLibphutil} $out/libphutil
    cp -R ${srcArcanist} $out/arcanist
    cp -R ${srcPhabricator} $out/phabricator
  '';

  meta = with stdenv.lib; {
    homepage = http://phabricator.org/;
    description = "A collection of web applications which help software companies build better software.";
    license = licenses.apache;
    platforms = platforms.linux;
  };
}
