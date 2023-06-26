import 'package:bootcamp_oua_f4/repositories/categories_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCardScreen extends ConsumerWidget {
  const ShoppingCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesRepo = ref.watch(categoriesProvider);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              print("${categoriesRepo.categories.length}");
            },
            child: Text("TEST DATA PRINT"),
        ),
      ),
    );
  }
}
