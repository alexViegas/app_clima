import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/clima_view_model.dart';
import 'viewmodels/favoritos_view_model.dart';
import 'views/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClimaViewModel()),
        ChangeNotifierProvider(create: (_) => FavoritosViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    ),
  );
}
