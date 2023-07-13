import 'package:flutter/material.dart';

import 'StatefulWidget/profile_screen.dart';
import 'StatelessWidget/ProductList.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Hello User'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  '../images/img1.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage('../images/img1.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Add To Do List'),
            onTap: () => handleButtonClick(context, 'ToDoList', 1),

            //  onTap: ToDoList(),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.production_quantity_limits),
            title: Text('Product'),
            onTap: () => handleButtonClick(context, 'Product', 2),

            //  onTap: ToDoList(),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.production_quantity_limits),
            title: Text('ChatGPT Duplicate'),
            onTap: () => handleButtonClick(context, 'chatgpt', 3),

            //  onTap: ToDoList(),
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
    );
  }

  handleButtonClick(BuildContext context, String datatext, int index) {
    if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductList()));
    }
  }
}
