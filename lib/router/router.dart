// ignore_for_file: prefer_final_fields

import 'package:fluro/fluro.dart';
import 'package:sellos/router/route_handlers.dart';

class Flurorouter {
  static final FluroRouter router = new FluroRouter();

  static void configureRoutes() {
    router.define(
      "/", 
      handler: counterHandler,
      transitionType: TransitionType.fadeIn
    );

    router.define(
      "/stateful", 
      handler: counterHandler,
      transitionType: TransitionType.fadeIn
    );

    router.define(
      "/stateful/:base", 
      handler: counterHandler,
      transitionType: TransitionType.fadeIn
    );

    router.define(
      "/dashboard/users/:userid/:roleid", 
      handler: dashboardUserHandler,
      transitionType: TransitionType.fadeIn
    );    

    router.notFoundHandler = pageNotFound;
  }
}