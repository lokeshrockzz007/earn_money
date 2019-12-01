import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsController extends StatefulWidget {
  @override
  _ContactsControllerState createState() => _ContactsControllerState();
}

class _ContactsControllerState extends State<ContactsController> {
  Iterable<Contact> contacts;

  @override
  void initState() async {
    contacts = await ContactsService.getContacts();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text("Text");
  }
}
