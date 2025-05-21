import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/friend/amistad.dart';

class GestorDeAmistades {
  List<Amistad> amistades = [];
  final String apiUrl = "http://localhost:3000/amistades";

  Future<void> cargarAmistades(String usuario) async {
    final response = await http.get(Uri.parse('$apiUrl?usuario=$usuario'));

    if (response.statusCode == 200) {
      List<dynamic> amistadesJson = json.decode(response.body);
      amistades.clear();
      amistades = amistadesJson.map((json) => Amistad.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar amistades');
    }
  }

  Future<void> agregarAmistad(Amistad amistad) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({"amistad": amistad.toJson()}),
    );

    if (response.statusCode == 201) {
      amistades.add(Amistad.fromJson(json.decode(response.body)));
    } else {
      throw Exception('Error al agregar amistad: ${response.body}');
    }
  }

  Future<void> eliminarAmistad(Amistad amistad) async {
    if (amistad.id == null) return;
    final response = await http.delete(Uri.parse('$apiUrl/${amistad.id}'));

    if (response.statusCode == 200 || response.statusCode == 204) {
      amistades.removeWhere((a) => a.id == amistad.id);
    } else {
      print("Error: ${response.statusCode} ${response.body}");
      throw Exception('Error al eliminar amistad');
    }
  }
}
