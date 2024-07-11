import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_day_55/cubits/counter/counter_cubit.dart';
import 'package:flutter_day_55/cubits/product/product_cubit.dart';
import 'package:flutter_day_55/ui/screens/products/products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterCubit()),
        BlocProvider(create: (context) => ProductCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductsScreen(),
      ),
    );
  }
}
