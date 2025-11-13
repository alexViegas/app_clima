import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosViewModel extends ChangeNotifier {
  List<String> _cidadesFavoritas = [];

  List<String> get cidadesFavoritas => _cidadesFavoritas;

  Future<void> carregarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    _cidadesFavoritas = prefs.getStringList('favoritos') ?? [];
    notifyListeners();
  }

  Future<void> adicionarFavorito(String cidade) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_cidadesFavoritas.contains(cidade)) {
      _cidadesFavoritas.add(cidade);
      await prefs.setStringList("favoritos", _cidadesFavoritas);
      notifyListeners();
    }
  }

  Future<void> removerFavoritos(String cidade) async {
    final prefs = await SharedPreferences.getInstance();
    _cidadesFavoritas.remove(cidade);
    await prefs.setStringList("favoritos", _cidadesFavoritas);
    notifyListeners();
  }
}
