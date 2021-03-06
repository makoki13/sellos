// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sellos/router/route_generator.dart';
import 'package:sellos/router/router.dart';
import 'package:sellos/services/navigation_service.dart';
import 'package:sellos/ui/layout/main_layout_page.dart';

import 'locator.dart';

void main() {
  setupLocator();
  Flurorouter.configureRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rutas App',
      initialRoute: '/',     
      //onGenerateRoute: RouteGenerator.generateRouter,
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: locator<NavigationService>().navigatorKey,
      builder: (_, child) {
        return MainLayoutPage(
          child: child ?? Container(),
        );
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white
      ),
      
    );
  }
}