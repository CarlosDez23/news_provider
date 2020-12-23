import 'package:flutter/material.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:news_provider/src/theme/theme.dart';

class ListaNoticias extends StatelessWidget {
  
  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: this.noticias[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({@required this.noticia, @required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardTopBar(noticia,index),
        _CardTitle(noticia),
        _CardImage(noticia),
        _CardBody(noticia),
        _CardButtons(),
        SizedBox(height:10),
        Divider(),
      ],
    );
  }
}

class _CardTopBar extends StatelessWidget {
  
  final Article noticia;
  final int index;

  const _CardTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${index+1}. ',
            style: TextStyle(color: theme.accentColor),
          ),
          Text(
            '${noticia.source.name}. ',
          )
        ],
      )
    );
  }
}

class _CardTitle extends StatelessWidget {

  final Article noticia;

  const _CardTitle(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        noticia.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ) 
    );
  }
}

class _CardImage extends StatelessWidget {

  final Article noticia;

  const _CardImage(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        ),
        child: Container(
          child: (this.noticia.urlToImage != null)
            ? FadeInImage(
              placeholder: AssetImage('assets/img/giphy.gif'),
              image: NetworkImage(this.noticia.urlToImage),
            )
            : Image(
              image: AssetImage('assets/img/no-image.png'),
            ),
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {

  final Article noticia;

  const _CardBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text((noticia.description != null) ? noticia.description : ''),
    );
  }
}

class _CardButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: theme.accentColor,
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 20.0),
          RawMaterialButton(
            onPressed: (){},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.blue,
            child: Icon(Icons.more),
          ),
        ],
      )
    );
  }
}