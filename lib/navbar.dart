import 'package:flutter/material.dart';

import 'StatefulWidget/chatGPTScreen.dart';
import 'StatefulWidget/todo_list.dart';
import 'StatelessWidget/product_list.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Hello User'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              // image: DecorationImage(
              //     fit: BoxFit.fill, image: NetworkImage('../images/img1.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Add To Do List'),
            onTap: () => handleButtonClick(context, 'ToDoList', 1),

            //  onTap: ToDoList(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits),
            title: const Text('Product'),
            onTap: () => handleButtonClick(context, 'Product', 2),

            //  onTap: ToDoList(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits),
            title: const Text('ChatGPT Duplicate'),
            onTap: () => handleButtonClick(context, 'chatgpt', 3),

            //  onTap: ToDoList(),
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  handleButtonClick(BuildContext context, String datatext, int index) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const TODOListScreen()));
  }
}
