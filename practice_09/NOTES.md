# Practice 9 Notes

## Level 1 — Lift it up

The cart state is owned by Shell above MaterialApp.
Data flows down through constructor parameters.
Callbacks flow up to Shell, where setState updates the cart.

Adding the total to the badge required updating two constructors:
BooksScreen and CartBadge.

Files changed: main.dart, books_screen.dart, cart_badge.dart.

BooksScreen contains six rows. Its build method logs one screen
message and six row messages per full build.

Actual rebuild observations will be recorded during testing.
