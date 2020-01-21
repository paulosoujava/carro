import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_listview.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    /*
    _tabController = TabController(length: 3, vsync: this);
    Future<int> future = Prefs.getInt(TipoCarro.KEY_TAB);
    future.then((int idx){
      _tabController.index = idx;
    });
    _tabController.addListener((){
     Prefs.setInt(TipoCarro.KEY_TAB, _tabController.index);
    });
    */
    _initTab();
  }

  _initTab() async {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = await Prefs.getInt(TipoCarro.KEY_TAB);
    _tabController.addListener(() {
      Prefs.setInt(TipoCarro.KEY_TAB, _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "Clássico",
            ),
            Tab(
              text: "Luxo",
            ),
            Tab(
              text: "Esportivos",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CarroListView(TipoCarro.classicos),
          CarroListView(TipoCarro.esportivos),
          CarroListView(TipoCarro.luxo),
        ],
      ),
      drawer: DrawerList(),
    );
  }
}
