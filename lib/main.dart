import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Contact {
  String name;
  String phoneNumber;

  Contact(this.name, this.phoneNumber);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  void addContact() {
    String name = nameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();

    if (name.isEmpty || phoneNumber.isEmpty) {
      return; // Do not add new items if either field is empty
    }

    setState(() {
      contacts.add(Contact(name, phoneNumber));
      nameController.clear();
      phoneNumberController.clear();
    });
  }

  void deleteContact(Contact contact) {
    setState(() {
      contacts.remove(contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contacts Screen'),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            SizedBox(height: 12,),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Enter Your Name Here",
                suffixIcon: Icon(Icons.drive_file_rename_outline_rounded),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 1, color: Colors.grey), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Your Name Here',
                suffixIcon: Icon(Icons.phone),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 1, color: Colors.grey), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 12,),
            Container(
              width: 200,
              height: 50,
              child: MaterialButton(
                onPressed: addContact,
                child: Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 12,),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      // shape: BoxShape.circle,
                    ),
                    child: ListTile(
                      title: Text(
                        "name:  ${contacts[index].name}",

                        style: TextStyle(fontSize: 25),
                      ),
                      subtitle: Text(
                        "phone:  ${contacts[index].phoneNumber}",

                        style: TextStyle(fontSize: 25),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,color: Colors.red),
                        onPressed: () => deleteContact(contact),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}