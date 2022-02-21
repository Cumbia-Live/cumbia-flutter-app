class LiveCategory {
  String id; // Id de la categoría
  String name; // Nombre de la categoría
  bool isSelected; // Si la categoría está seleccionada o no para un filtro
  int votes;

  LiveCategory({
    this.id,
    this.name,
    this.isSelected,
    this.votes
  });
}
