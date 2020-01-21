import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/user.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future<User> future = User.get();
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<User>(
              future:  future,
              builder: ( context, snapshot){
                User user = snapshot.data;
                return user != null ? _buildUserAccountsDrawerHeader(user) : Container();
              }
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

   _buildUserAccountsDrawerHeader(User user) {
    return UserAccountsDrawerHeader(
            accountName: Text(user.nome),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.urlFoto),
            ),
          );
  }

  _onClickLogout(BuildContext context) {
    User.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}