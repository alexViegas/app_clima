import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/favoritos_view_model.dart';
import '../viewmodels/clima_view_model.dart';

class FavoritosView extends StatefulWidget {
  const FavoritosView({Key? key}) : super(key: key);

  @override
  State<FavoritosView> createState() => _FavoritosViewState();
}

class _FavoritosViewState extends State<FavoritosView> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavoritosViewModel>(context, listen: false).carregarFavoritos();
  }

  @override
  Widget build(BuildContext context) {
    final favoritosVM = Provider.of<FavoritosViewModel>(context);
    final climaVM = Provider.of<ClimaViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Cidades Favoritas')),
      body:
          favoritosVM.cidadesFavoritas.isEmpty
              ? const Center(child: Text('Nenhuma cidade favorita.'))
              : ListView.builder(
                itemCount: favoritosVM.cidadesFavoritas.length,
                itemBuilder: (context, index) {
                  final cidade = favoritosVM.cidadesFavoritas[index];
                  return ListTile(
                    title: Text(cidade),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        favoritosVM.removerFavoritos(cidade);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${climaVM.previsao!.cidade} removido(a) dos favoritos!',
                            ),
                          ),
                        );
                      },
                    ),
                    onTap: () async {
                      await climaVM.buscarClima(cidade);
                      if (mounted) Navigator.pop(context);
                    },
                  );
                },
              ),
    );
  }
}
