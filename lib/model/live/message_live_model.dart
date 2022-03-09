class Message {
  String userId; // Id del usario que envía el usuario
  String username; // username que se muestra en el mensaje
  String profilePictureURL; // imagen de perfil de quein envía el mensaje
  String messageId; // id del mensjae que proporciona la base de datos
  String message; // Mensaje que manda el usuario
  int created; // Fecha de creación del mensaje dada en millisecondsSinceEpoch


  Message(
      {
      this.message,
      this.created,
      this.messageId,
      this.username,
      this.profilePictureURL,
      this.userId});
}
