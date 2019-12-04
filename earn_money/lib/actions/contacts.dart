import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsController extends StatefulWidget {
  @override
  _ContactsControllerState createState() => _ContactsControllerState();
}

class _ContactsControllerState extends State<ContactsController> {
  Iterable<Contact> contacts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData != null) {
          return Container(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrangeAccent,
            ),
          );
        }
        contacts = snapshot.data != null ? snapshot.data : [];
        return ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(contacts.elementAt(index).displayName),
                // Provide a function that tells the app
                // what to do after an item has been swiped away.
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  // setState(() {
                  //   items.removeAt(index);
                  // });

                  // Then show a snackbar.
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "${contacts.elementAt(index).displayName} dismissed")));
                },
                // Show a red background as the item is swiped away.
                background: Container(color: Colors.red),
                secondaryBackground: Container(
                  color: Colors.greenAccent,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.message,
                    color: Colors.deepOrange,
                  ),
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.deepOrange,
                  ),
                  title: Text(contacts.elementAt(index).displayName),
                  subtitle: Text(contacts.elementAt(index).phones.first.value),
                ),
              );
            },
            itemCount: contacts.length);
      },
    );
  }

  Future<Iterable<Contact>> getContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    return contacts;
  }
}
