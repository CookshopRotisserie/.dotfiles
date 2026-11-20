{ stdenv, fetchFromGitHub, }:

stdenv.mkDerivation rec {
  pname = "sddm-sugar-dark";
  version = "1.2";
  dontBuild = true;
  installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
    '';
  src = fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "v${version}";
    hash = "sha256-C3qB9hFUeuT5+Dos2zFj5SyQegnghpoFV9wHvE9VoD8=";
  };
}
