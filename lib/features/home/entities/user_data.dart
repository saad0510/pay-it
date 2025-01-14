class UserData {
  final String name;
  final String imageUrl;

  const UserData({
    required this.name,
    required this.imageUrl,
  });

  static const randomUsers = [
    UserData(
      name: 'Mr. Saad',
      imageUrl: 'https://i.pravatar.cc/300?img=12',
    ),
    UserData(
      name: 'Bill Gates',
      imageUrl: 'https://i.pravatar.cc/300?img=13',
    ),
    UserData(
      name: 'Elon Musk',
      imageUrl: 'https://i.pravatar.cc/300?img=15',
    ),
    UserData(
      name: 'Mr. Steve',
      imageUrl: 'https://i.pravatar.cc/300?img=17',
    ),
  ];
}
