{ lib
, fetchFromGitHub
, python3
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  pname = "gyb";
  version = "1.62";
  format = "other";

  src = fetchFromGitHub {
    owner = "GAM-team";
    repo = "got-your-back";
    rev = "v${version}";
    sha256 = "sha256-HaexQ0y5i9Q0xgjzAX6E2xeyeDvARo7/Gx3ytohRT7U=";
  };

  propagatedBuildInputs = with python3Packages; [
    google-api-python-client
    google-auth
    google-auth-oauthlib
    google-auth-httplib2
    httplib2
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,${python3.sitePackages}}
    mv gyb.py "$out/bin/gyb"
    mv *.py "$out/${python3.sitePackages}/"

    runHook postInstall
  '';

  checkPhase = ''
    $out/bin/gyb --help > /dev/null
  '';

  meta = with lib; {
    description = ''
      Got Your Back (GYB) is a command line tool for backing up your Gmail
      messages to your computer using Gmail's API over HTTPS.
    '';
    homepage = "https://github.com/GAM-team/got-your-back";
    license = licenses.asl20;
    maintainers = with maintainers; [ austinbutler ];
  };
}
