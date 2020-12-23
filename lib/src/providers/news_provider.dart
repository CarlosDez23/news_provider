import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = '3e58a9e471da46bb96d0a8e60db3e616';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  String _selectedCategory = 'business';

  Map<String, List<Article>> categoryArticles = {};


  NewsService(){
    this.getTopHeadlines();
    categories.forEach((element) {
      this.categoryArticles[element.name] = new List();
    });
    this.getArticlesByCategory(this._selectedCategory);
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String value){
    this._selectedCategory = value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get articlesOfSelectedCategory => this.categoryArticles[this._selectedCategory];


  void getTopHeadlines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=us';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if(this.categoryArticles[category].length > 0){
      return this.categoryArticles[category];
    }
    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=us&category=$category';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}