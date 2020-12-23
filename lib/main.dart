import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/tabs_page.dart';
import 'package:news_provider/src/providers/news_provider.dart';
import 'package:news_provider/src/theme/theme.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        title: 'Material App',
        home: TabsPage(),
      ),
    );
  }
}