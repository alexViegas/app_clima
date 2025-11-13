class PrevisaoClima {
  final String cidade;
  final double temperatura;
  final String descricao;
  final bool chuva;

  PrevisaoClima({
    required this.cidade,
    required this.temperatura,
    required this.descricao,
    required this.chuva,
  });

  factory PrevisaoClima.fromJson(Map<String, dynamic> json) {
    return PrevisaoClima(
      cidade: json['name'],
      temperatura: json['main']['temp'].toDouble(),
      descricao: json['weather'][0]['description'],
      chuva: json['weather'][0]['main'].toLowerCase().contains('rain'),
    );
  }
}
