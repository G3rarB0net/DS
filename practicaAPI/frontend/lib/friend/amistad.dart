class Amistad{
  final int? id;
  final String usuario;
  final String amistadCon;

  Amistad({
    required this.id,
    required this.usuario,
    required this.amistadCon
  });

  void mostrar(){
    print("$usuario tiene amistad con $amistadCon");
  }

  factory Amistad.fromJson(Map<String, dynamic> json) {
    return Amistad(
      id: json['id'],
      usuario: json['usuario'],
      amistadCon: json['amistadCon'],
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'usuario': usuario,
    'amistadCon': amistadCon,
  };
}