import 'package:flutter/material.dart';
import 'package:sellos/ui/pages/counter_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sellos/ui/views/counter_view.dart';

import '../ui/views/counter_provider_view.dart';
import '../ui/views/view_404.dart';

//import '../ui/pages/counter_provider_page.dart';
//import '../ui/pages/page_404.dart';


class RouteGenerator {
  static Route<dynamic> generateRouter(RouteSettings settings ) {

    print(settings.name);
    switch( settings.name) {
      case '/stateful':
        return _fadeRoute(CounterView(), '/stateful');

      case '/provider':
        return _fadeRoute(CounterProviderView(), '/provider');

      default:
        return _fadeRoute(View404(), '/404');
    }    
  }

  static PageRoute _fadeRoute(Widget child, String routeName) {    
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => child,
      transitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (_, animation, __, ___) => 
        (kIsWeb) 
        ?
          FadeTransition(
            opacity: animation,
            child: child,
          )
        :
          CupertinoPageTransition(primaryRouteAnimation: animation,  linearTransition: true, secondaryRouteAnimation: __, child: child)
    );
  }
}