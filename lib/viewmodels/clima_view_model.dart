import 'package:app_clima/services/localizacao_service.dart';
import 'package:flutter/foundation.dart';
import '../models/previsao_model.dart';
import '../services/clima_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClimaViewModel extends ChangeNotifier {
  final ClimaService _service = ClimaService();
  final LocalizacaoService _localizacaoService = LocalizacaoService();

  PrevisaoClima? previsao;
  bool carregando = false;
  String? erro;

  List<String> cidadesFavoritas = [];

  ClimaViewModel() {
    _carregarFavoritos();
  }

  // Buscar cidade/clima
  Future<void> buscarClima(String cidade) async {
    try {
      carregando = true;
      erro = null;
      notifyListeners();

      previsao = await _service.buscarClima(cidade);
    } catch (e) {
      erro = e.toString();
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  // verificação favoritos
  bool ehFavorito(String cidade) {
    return cidadesFavoritas.contains(cidade);
  }

  // Salvar cidade nos favoritos
  Future<void> adicionarFavorito(String cidade) async {
    if (!cidadesFavoritas.contains(cidade)) {
      cidadesFavoritas.add(cidade);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favoritos', cidadesFavoritas);
      notifyListeners();
    }
  }

  // Remover cidade dos favoritos
  Future<void> removerFavorito(String cidade) async {
    cidadesFavoritas.remove(cidade);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoritos', cidadesFavoritas);
    notifyListeners();
  }

  // Carregar favoritos ao iniciar
  Future<void> _carregarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    cidadesFavoritas = prefs.getStringList('favoritos') ?? [];
    notifyListeners();
  }

  //Buscar o clima da localização atual

  Future<void> buscarClimaAtual() async {
    try {
      carregando = true;
      erro = null;
      notifyListeners();

      final cidade = await _localizacaoService.obterCidadeAtual();
      if (cidade == null) {
        erro = 'Não foi possível determinar sua cidade.';
        carregando = false;
        notifyListeners();
        return;
      }

      previsao = await _service.buscarClima(cidade);
    } catch (e) {
      erro = e.toString();
    } finally {
      carregando = false;
      notifyListeners();
    }
  }
}
