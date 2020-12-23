import 'package:flutter/material.dart';
import 'package:news_provider/src/providers/news_provider.dart';
import 'package:news_provider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

//Para mantener el estado del scroll cuando cambiemos de pantalla
class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsProvider = Provider.of<NewsService>(context);
    return Scaffold(
      body: (newsProvider.headlines.length == 0)
        ? Center(
          child: CircularProgressIndicator(),
        )
        : ListaNoticias(newsProvider.headlines)
    );
  }

  //Implementación necesaria por el mixing de AutomaticKeepAliveClientMixin
  @override
  bool get wantKeepAlive => true;
}