class VentaModel {
  final String nombre;
  final String desc;
  final int cant;
  final int emeralds;
  final int cumbiap;
  final DateTime fecha;
  String imageUrl;

  VentaModel(this.nombre, this.desc, this.emeralds, this.cumbiap, this.fecha,
      this.cant,
      {this.imageUrl});
}
