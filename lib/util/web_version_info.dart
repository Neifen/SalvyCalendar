class WebVersionInfo {
  static const bool showVersion = true;
  static const String name = '2.0.1';

  static String getVersionNr() {
    //could be async in future if package_info allows web tow ork
    if (!showVersion) return "created by Nathan Bourquin - neifen.b@gmail.com";

    return "created by Nathan Bourquin - neifen.b@gmail.com - $name - ";
  }
}
