import 'package:flutter/material.dart';
import 'package:solid_chat/data/models/contact.dart';
import 'chat_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Conversations',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: Colors.black,
            onPressed: () {

            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allContacts.length,
              itemBuilder: (context, index) {
                final contact = allContacts[index];
                return Container(
                  width: 70,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.redAccent,
                      width: 3,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      contact.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allContacts.length,
              itemBuilder: (context, index) {
                final contact = allContacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact.imageUrl),
                  ),
                  title: Text(contact.contactName),
                  subtitle: const Text('Last message preview'),
                  trailing: index % 4 == 0
                      ? const Icon(
                          Icons.check,
                          color: Colors.redAccent,
                        )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(contactId: contact.contactId),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Conversations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        selectedItemColor: Colors.redAccent,
      ),
    );
  }
}
