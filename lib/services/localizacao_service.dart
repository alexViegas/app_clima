class LocalizacaoService {
  Future<String?> obterCidadeAtual() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnable();
    if (!servicoAtivo) {
      throw Exception('Serviço de localização desativado');
    }

    LocationPermission permissao = await Geolicator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        throw Exception('Permissão negada');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      throw Exception('Permissão permanente negada');
    }

    //Coordenadas
  }
}
