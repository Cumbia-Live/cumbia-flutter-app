import 'dart:io' show Platform;

enum Dispositivo {
  ios,
  android,
  otro,
}

Dispositivo getDispositivoType() {
  if (Platform.isIOS) {
    return Dispositivo.ios;
  } else if (Platform.isAndroid) {
    return Dispositivo.android;
  } else {
    return Dispositivo.otro;
  }
}
