import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/clima_view_model.dart';
import '../viewmodels/favoritos_view_model.dart';
import 'favoritos_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final climaVM = Provider.of<ClimaViewModel>(context);
    final favoritosVM = Provider.of<FavoritosViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('App de Clima'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            tooltip: 'Favoritos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritosView()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite o nome da cidade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                climaVM.buscarClima(_controller.text);
              },
              child: const Text('Buscar Clima'),
            ),
            const SizedBox(height: 20),
            if (climaVM.carregando)
              const CircularProgressIndicator()
            else if (climaVM.previsao != null)
              Column(
                children: [
                  Text(
                    climaVM.previsao!.cidade,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Temperatura: ${climaVM.previsao!.temperatura.toStringAsFixed(1)} °C',
                  ),
                  Text('Descrição: ${climaVM.previsao!.descricao}'),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      favoritosVM.adicionarFavorito(climaVM.previsao!.cidade);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${climaVM.previsao!.cidade} adicionada aos favoritos!',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite),
                    label: const Text('Salvar cidade como favorita'),
                  ),
                ],
              )
            else if (climaVM.erro != null)
              Text(climaVM.erro!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
