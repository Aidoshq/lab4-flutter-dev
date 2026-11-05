class Book {
  const Book({required this.title, required this.author, required this.price});

  final String title;
  final String author;
  final int price;
}

const books = [
  Book(title: 'Абай жолы', author: 'Мұхтар Әуезов', price: 5500),
  Book(title: 'Қара сөздер', author: 'Абай Құнанбайұлы', price: 3200),
  Book(title: 'Менің атым Қожа', author: 'Бердібек Соқпақбаев', price: 2800),
  Book(title: 'Көшпенділер', author: 'Ілияс Есенберлин', price: 6500),
  Book(title: 'Бақытсыз Жамал', author: 'Міржақып Дулатұлы', price: 3700),
  Book(title: 'Ұшқан ұя', author: 'Бауыржан Момышұлы', price: 4200),
];
