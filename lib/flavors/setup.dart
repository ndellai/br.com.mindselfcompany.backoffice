enum FlavorType {
  DEV,
  PRD,
}

class Setup {
  static FlavorType appFlavor;

  static String get title {
    String title;

    switch (appFlavor) {
      case FlavorType.DEV:
        title = 'MindSelf - MeDiT - Dev';
        break;
      case FlavorType.PRD:
        title = 'MindSelf - MeDiT - BackOffice';
        break;
      default:
        title = 'MindSelf - MeDiT - BackOffice';
        break;
    }

    return title;
  }

  static String get apiBaseUrl {
    String url;

    switch (appFlavor) {
      case FlavorType.DEV:
        url = "http://192.168.15.127:${_apiBasePort.toString()}";
        break;
      case FlavorType.PRD:
        url = "https://www.mindself.services:${_apiBasePort.toString()}";
        break;
      default:
        url = "https://www.mindself.services:${_apiBasePort.toString()}";
        break;
    }

    return url;
  }

  static int get _apiBasePort {
    int port = 0;

    switch (appFlavor) {
      case FlavorType.DEV:
        port = 52728;
        break;
      case FlavorType.PRD:
        port = 443;
        break;
      default:
        port = 443;
        break;
    }

    return port;
  }
}
