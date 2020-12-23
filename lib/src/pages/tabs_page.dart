import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/tab1_page.dart';
import 'package:news_provider/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final navegacionModel = Provider.of<_NavegacionModel>(context);
  
    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (newIndex) => navegacionModel.paginaActual = newIndex, 
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Para ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados',
        ),
      ]
    );
  }
}

class _Paginas extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {

  int _paginaActual = 0;
  PageController _pageController = PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int value) {
    this._paginaActual = value;
    this._pageController.animateToPage(
      value, 
      duration: Duration(milliseconds:250), 
      curve: Curves.easeOut
    );
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}