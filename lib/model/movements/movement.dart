class Movement {
  final String nombre;
  final String tipo;
  final String descripcion;
  final DateTime fecha;
  final bool status;
  final int valor;

  Movement(this.nombre, this.descripcion, this.fecha, this.status, this.valor,
      this.tipo);
}
