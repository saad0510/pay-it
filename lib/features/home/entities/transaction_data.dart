class TransactionData {
  final String title;
  final String category;
  final double price;
  final String imageUrl;

  const TransactionData({
    required this.title,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  static const randomTransactions = [
    TransactionData(
      title: 'Starbucks',
      category: 'Food & Drink',
      price: 5.75,
      imageUrl: 'https://www.freepnglogos.com/uploads/starbucks-logo-png-25.png',
    ),
    TransactionData(
      title: 'PayPal',
      category: 'Transfers',
      price: 50.00,
      imageUrl:
          'https://www.numeroservicioalcliente.com/wp-content/uploads/2021/12/10304710_10152033784102611_8320996065442654531_n.png',
    ),
    TransactionData(
      title: 'Walmart',
      category: 'Groceries',
      price: 45.23,
      imageUrl: 'https://www.freepnglogos.com/uploads/walmart-logo-7.jpeg',
    ),
    TransactionData(
      title: 'Netflix',
      category: 'Entertainment',
      price: 15.99,
      imageUrl: 'https://www.freepnglogos.com/uploads/netflix-logo-circle-png-5.png',
    ),
    TransactionData(
      title: 'Apple Store',
      category: 'Electronics',
      price: 199.00,
      imageUrl: 'https://file.bodnara.co.kr/up/news/131201-logo_apple.jpg',
    ),
    TransactionData(
      title: 'Uber',
      category: 'Transport',
      price: 14.9,
      imageUrl: 'https://logodownload.org/wp-content/uploads/2015/05/uber-logo-1-1.png',
    ),
  ];
}
