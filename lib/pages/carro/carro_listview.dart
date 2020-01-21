import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarroListView extends StatefulWidget {
  String tipo;

  CarroListView(this.tipo);

  @override
  _CarroListViewState createState() => _CarroListViewState();
}

class _CarroListViewState extends State<CarroListView>
    with AutomaticKeepAliveClientMixin<CarroListView> {
  List<Carro> carros;
  final _bloc = CarrosBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc.fetch(widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print(">> ${snapshot.error.toString()}");
          return AppError("Ops deu erro no servidor");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro c = carros[index];
            return Card(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        c.urlFoto ??
                            "https://www.google.com.br/imgres?imgurl=https%3A%2F%2Fstatic3.tcdn.com.br%2Fimg%2Fimg_prod%2F232876%2Fcapa_para_cobrir_carro_p_m_g_impermeavel_com_forro_gofrada_1371_1_20190329163322.jpg&imgrefurl=https%3A%2F%2Fwww.generalcar.com.br%2Facessorios-externos%2Fcapas-automotivas%2Fcapa-de-cobrir-carro%2Fcapa-para-cobrir-carro-protetora-com-forro-impermeavel-gofrada-p-m-g&docid=vmu1fW02BThiGM&tbnid=Ya1JWdO6Pj7EcM%3A&vet=10ahUKEwiM1tLIj5PnAhVMJt8KHf4yCyoQMwhNKAkwCQ..i&w=1200&h=1200&safe=off&bih=682&biw=1024&q=carro&ved=0ahUKEwiM1tLIj5PnAhVMJt8KHf4yCyoQMwhNKAkwCQ&iact=mrc&uact=8",
                        width: 250,
                      ),
                    ),
                    Text(
                      c.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      c.descricao ?? "Sem descrição",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    // ignore: deprecated_member_use
                    ButtonBarTheme(
                      data: ButtonBarTheme.of(context),
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETALHES'),
                            onPressed: () {
                              push(context, CarroPage(c));
                            },
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () {
                              /* ... */
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
