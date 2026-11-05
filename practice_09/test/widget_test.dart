
import 'package:flutter_test/flutter_test.dart';
import 'package:practice_09/models/book.dart';
import 'package:practice_09/models/cart.dart';

void main() {
  test('Cart adds books and calculates total', () {
    final cart = Cart();

    expect(cart.count, 0);
    expect(cart.total, 0);

    // Add two books
    expect(cart.add(books[0]), true);
    expect(cart.add(books[1]), true);

    expect(cart.count, 2);
    expect(cart.total, 8700);

    // Duplicate books are not allowed
    expect(cart.add(books[0]), false);
    expect(cart.count, 2);

    // Increase quantity
    cart.increment(books[0]);

    expect(cart.qtyOf(books[0]), 2);
    expect(cart.total, 14200);

    // Remove one book
    cart.remove(books[1]);

    expect(cart.count, 1);
    expect(cart.total, 11000);

    // Clear cart
    cart.clear();

    expect(cart.count, 0);
    expect(cart.total, 0);

    cart.dispose();
  });
}
