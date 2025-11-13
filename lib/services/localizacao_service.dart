import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocalizacaoService {
  Future<String?> obterCidadeAtual() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();
    if (!servicoAtivo) {
      throw Exception('Serviço de localização desativado');
    }

    LocationPermission permissao = await Geolocator.checkPermission();
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
    Position posicao = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //Converter coordenada para nome da cidade
    List<Placemark> placemarks = await placemarkFromCoordinates(
      posicao.latitude,
      posicao.longitude,
    );

    return placemarks.first.locality;
  }
}
