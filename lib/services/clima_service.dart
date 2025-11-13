import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/previsao_model.dart';

class ClimaService {
  final String apiKey =
      "b24302cd4eed28b3a2e4a627f0f230c7"; // coloque sua chave aqui

  Future<PrevisaoClima> buscarClima(String cidade) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$apiKey&units=metric&lang=pt_br",
    );

    final resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      return PrevisaoClima.fromJson(jsonDecode(resposta.body));
    } else {
      throw Exception("Erro ao buscar clima");
    }
  }
}
