{ pkgs, stdenv, callPackage }:

self: {

  "elm-compiler" = callPackage
     ({ mkDerivation, aeson, aeson-pretty, ansi-terminal, base, binary
      , blaze-html, blaze-markup, bytestring, cmdargs, containers
      , directory, edit-distance, filemanip, filepath, HUnit, indents
      , language-ecmascript, language-glsl, mtl, parsec, pretty, process
      , QuickCheck, stdenv, test-framework, test-framework-hunit
      , test-framework-quickcheck2, text, transformers, union-find
      , unordered-containers, fetchFromGitHub
      }:
      mkDerivation rec {
        pname = "elm-compiler";
        version = "0.15.1";
        src = fetchFromGitHub {
          owner = "elm-lang";
          repo = pname;
          rev = version;
          sha256 = "1i8shbga4h42acgjdacg52l6fh8iz5vy4yfgajw3mm85gz9fn55p";
        };
        isLibrary = true;
        isExecutable = true;
        buildDepends = [
          aeson aeson-pretty ansi-terminal base binary blaze-html
          blaze-markup bytestring cmdargs containers directory edit-distance
          filepath indents language-ecmascript language-glsl mtl parsec
          pretty process text transformers union-find unordered-containers
        ];
        testDepends = [
          aeson aeson-pretty ansi-terminal base binary blaze-html
          blaze-markup bytestring cmdargs containers directory edit-distance
          filemanip filepath HUnit indents language-ecmascript language-glsl
          mtl parsec pretty process QuickCheck test-framework
          test-framework-hunit test-framework-quickcheck2 text transformers
          union-find
        ];
        jailbreak = true;
        homepage = "http://elm-lang.org";
        description = "Values to help with elm-package, elm-make, and elm-lang.org.";
        license = stdenv.lib.licenses.bsd3;
      }) {};

  "elm-make" = callPackage
    ({ mkDerivation, aeson, ansi-wl-pprint, base, binary, blaze-html
     , blaze-markup, bytestring, containers, directory, elm-compiler
     , elm-package, filepath, mtl, optparse-applicative, text, fetchFromGitHub
     }:
     mkDerivation rec {
       pname = "elm-make";
       version = "0.2";
       src = fetchFromGitHub {
         owner = "elm-lang";
         repo = pname;
         rev = version;
         sha256 = "0fksfailzql1pgrs0faa9vcr1ks4f8sgvm1j4s1nhqf0bwc943s4";
       };
       isLibrary = false;
       isExecutable = true;
       buildDepends = [
         aeson ansi-wl-pprint base binary blaze-html blaze-markup bytestring
         containers directory elm-compiler elm-package filepath mtl
         optparse-applicative text
       ];
       jailbreak = true;
       homepage = "http://elm-lang.org";
       description = "A build tool for Elm projects";
       license = stdenv.lib.licenses.bsd3;
       hydraPlatforms = stdenv.lib.platforms.none;
     }) {};

  "elm-package" = callPackage
    ({ mkDerivation, aeson, aeson-pretty, ansi-wl-pprint, base, binary
     , bytestring, containers, directory, elm-compiler, filepath, HTTP
     , http-client, http-client-tls, http-types, mtl, network
     , optparse-applicative, pretty, process, text, time
     , unordered-containers, vector, zip-archive, fetchFromGitHub
     }:
     mkDerivation rec {
       pname = "elm-package";
       version = "0.5.1"; # TODO: make this version something else?
       src = fetchFromGitHub {
         owner = "elm-lang";
         repo = pname;
         # Fix for building with 7.10 is a bit beyond 0.5.1
         rev = "af517f2ffe15f8ec1d8c38f01ce188bbdefea47a";
         sha256 = "1rdxa1vrz0h6iy7r4k3w9pmv65v75n21flrmb9spi7npij7g2l9c";
       };
       isLibrary = true;
       isExecutable = true;
       buildDepends = [
         aeson aeson-pretty ansi-wl-pprint base binary bytestring containers
         directory elm-compiler filepath HTTP http-client http-client-tls
         http-types mtl network optparse-applicative pretty process text
         time unordered-containers vector zip-archive
       ];
       jailbreak = true;
       homepage = "http://github.com/elm-lang/elm-package";
       description = "Package manager for Elm libraries";
       license = stdenv.lib.licenses.bsd3;
       hydraPlatforms = stdenv.lib.platforms.none;
     }) {};

  "elm-reactor" = callPackage
    ({ mkDerivation, base, blaze-html, blaze-markup, bytestring
     , cmdargs, containers, directory, elm-compiler, elm-make, filepath
     , fsnotify, HTTP, mtl, process, snap-core, snap-server, system-filepath
     , text, time, transformers, unordered-containers, websockets
     , websockets-snap, fetchFromGitHub
     }:
     mkDerivation rec {
       pname = "elm-reactor";
       version = "0.3.2"; # TODO: bump to something else?
       src = fetchFromGitHub {
         owner = "elm-lang";
         repo = pname;
         # Fix for building with 7.10 is a bit beyond 0.3.2
         rev = "ca4d91d3fc7c6f72aa802d79fd1563ab5f3c4f2c";
         sha256 = "1kydmf5vjc647cs5rzqww0qk5gqk8l22a28259jhd9b9x4vrqdv4";
       };
       isLibrary = false;
       isExecutable = true;
       buildDepends = [
         base blaze-html blaze-markup bytestring cmdargs containers
         directory elm-compiler elm-make filepath fsnotify HTTP mtl
         process snap-core snap-server system-filepath text time transformers
         unordered-containers websockets websockets-snap
       ];
       preConfigure = "export HOME=$TEMPDIR";
       homepage = "http://elm-lang.org";
       description = "Interactive development tool for Elm programs";
       license = stdenv.lib.licenses.bsd3;
       hydraPlatforms = stdenv.lib.platforms.none;
     }) {};

  "elm-repl" = callPackage
    ({ mkDerivation, base, binary, bytestring, bytestring-trie, cmdargs
     , containers, directory, elm-compiler, elm-package, filepath
     , haskeline, HUnit, mtl, parsec, process, QuickCheck
     , test-framework, test-framework-hunit, test-framework-quickcheck2
     , fetchFromGitHub, nodejs, elm-make, makeWrapper
     }:
     mkDerivation rec {
       pname = "elm-repl";
       version = "0.4.2";
       src = fetchFromGitHub {
         owner = "elm-lang";
         repo = pname;
         rev = version;
         sha256 = "1x508bkpzzyf0f6p6q4vcc0mp2hddhlzfsn65qfy0hxfqgac075g";
       };
       isLibrary = false;
       isExecutable = true;
       buildDepends = [
         base binary bytestring bytestring-trie cmdargs containers directory
         elm-compiler elm-package filepath haskeline mtl parsec process
       ];
       testDepends = [
         base bytestring bytestring-trie cmdargs directory elm-compiler
         elm-package filepath haskeline HUnit mtl parsec process QuickCheck
         test-framework test-framework-hunit test-framework-quickcheck2
       ];
       buildTools = [ makeWrapper ];
       postInstall = ''
         wrapProgram "$out/bin/elm-repl" \
           --prefix PATH : ${elm-make}/bin \
           --prefix PATH : ${nodejs}/bin
       '';
       homepage = "https://github.com/elm-lang/elm-repl";
       description = "a REPL for Elm";
       license = stdenv.lib.licenses.bsd3;
       hydraPlatforms = stdenv.lib.platforms.none;
     }) {};

}
