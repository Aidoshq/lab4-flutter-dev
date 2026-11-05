import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/book.dart';
import 'models/cart.dart';
import 'cart_badge.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    debugPrint('BooksScreen build');

    final filtered = books.where(
      (book) => book.title.toLowerCase().contains(search.toLowerCase()),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Shop'),
        actions: const [CartBadge(), SizedBox(width: 16)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search books',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => search = value),
            ),
          ),
          Expanded(
            child: ListView(
              children: filtered.map((book) {
                return _BookRow(book: book);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookRow extends StatelessWidget {
  const _BookRow({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    debugPrint('row ${book.title}');

    final added = context.select<Cart, bool>(
      (cart) => cart.items.contains(book),
    );

    return ListTile(
      title: Text(book.title),
      subtitle: Text('${book.author} • ${book.price} ₸'),
      trailing: added
          ? const Text('Added')
          : OutlinedButton(
              onPressed: () {
                final ok = context.read<Cart>().add(book);
                if (ok) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
    );
  }
}
