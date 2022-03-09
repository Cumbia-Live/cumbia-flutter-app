// Estos prints agilizan la comunicación de las operaciones del back.
// Ayudan a tener logs que se identifican más fácil.

class LogMessage {
  // Lectura
  static void get(String message) => print("🔍 OBTENDRÉ: $message");
  static void getSuccess(String message) => print("👍 OBTENIDO: $message");
  static void getError(String message, e) =>
      print("💩 ERROR AL OBTENER $message: $e");
  // Escritura
  static void post(String message) => print("✏️ SUBIRÉ: $message");
  static void postSuccess(String message) => print("👍 SUBIDO: $message");
  static void postError(String message, e) =>
      print("💩 ERROR AL SUBIR $message: $e");
  // Eliminación
  static void delete(String message) => print("✏️ ELIMINARÉ: $message");
  static void deleteSuccess(String message) => print("👍 ELIMINADO: $message");
  static void deleteError(String message, e) =>
      print("💩 ERROR AL ELIMINAR $message: $e");
}
