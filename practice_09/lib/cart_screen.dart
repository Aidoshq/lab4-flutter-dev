import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/book.dart';
import 'models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _confirmClear(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear cart?'),
        content: const Text('Remove all books from the cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;
    if (confirmed == true) {
      context.read<Cart>().clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          IconButton(
            tooltip: 'Clear cart',
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => _confirmClear(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<Cart>(
              builder: (context, cart, _) {
                if (cart.items.isEmpty) {
                  return const Center(child: Text('Your cart is empty'));
                }

                return ListView(
                  children: cart.items.map((book) {
                    return _CartRow(book: book, cart: cart);
                  }).toList(),
                );
              },
            ),
          ),
          Consumer<Cart>(
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.receipt_long),
                SizedBox(width: 8),
                Text('Total'),
              ],
            ),
            builder: (context, cart, child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    child!,
                    Text(
                      '${cart.total} ₸',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CartRow extends StatelessWidget {
  const _CartRow({required this.book, required this.cart});

  final Book book;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text('${book.price} ₸ × ${cart.qtyOf(book)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Increase quantity',
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => cart.increment(book),
          ),
          IconButton(
            tooltip: 'Remove book',
            icon: const Icon(Icons.close),
            onPressed: () => cart.remove(book),
          ),
        ],
      ),
    );
  }
}
