import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_market_explorer/home_screen.dart';
import 'blocs/product/product_event.dart';
import 'blocs/product/product_bloc.dart';
import 'repositories/product_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global Market Explorer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => ProductBloc(ProductRepository())..add(LoadProducts()),
        child: HomeScreen(),
      ),
    );
  }
}
