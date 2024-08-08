class ContactModel {
  final int contactId;
  final String contactName;
  final String contactLasName;
  final bool isOnline;
  final String imageUrl;
  final DateTime lastOnlineTime;

  ContactModel({
    required this.contactId,
    required this.contactLasName,
    required this.contactName,
    required this.isOnline,
    required this.imageUrl,
    required this.lastOnlineTime,
  });
}

List<ContactModel> allContacts = [
  ContactModel(
    contactId: 3,
    contactLasName: "Xasan",
    contactName: "Karimovich",
    isOnline: true,
    imageUrl:
        "https://cdn-icons-png.freepik.com/512/180/180656.png?ga=GA1.1.969355796.1713496108",
    lastOnlineTime: DateTime.now(),
  )
];
