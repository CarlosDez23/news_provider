import 'package:flutter/material.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/providers/news_provider.dart';
import 'package:news_provider/src/theme/theme.dart';
import 'package:news_provider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategorias(),
            (newsService.articlesOfSelectedCategory.length == 0)
            ? Expanded(child: Center(child: CircularProgressIndicator()))
            : Expanded(child: ListaNoticias(newsService.articlesOfSelectedCategory)),
          ],
        )
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context);

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final categoryName = categories.categories[index].name;
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                _CategoryButton(categories.categories[index]),
                SizedBox(height: 5.0),
                Text(
                  '${categoryName[0].toUpperCase()}${categoryName.substring(1)}'
                ),
              ]
            )
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: (){
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (categoria.name == newsService.selectedCategory)
            ? theme.accentColor
            : Colors.black54,
        )
      ),
    );
  }
}