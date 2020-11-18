library plato.cap;

import 'dart:async' show runZoned;
import 'dart:html' show window;

import 'package:angular/angular.dart';

import 'package:http/http.dart' show Client;
import 'package:http/browser_client.dart' show BrowserClient;

import 'package:plato.cap/src/plato_cap_component.template.dart' as capNg;

import 'main.template.dart' as capMain;

@GenerateInjector(
  [ClassProvider (Client, useClass: BrowserClient)]
)
final InjectorFactory clientInjector = capMain.clientInjector$Injector;

/// The [main] function...
void main() {
  runZoned (() {
    runApp (capNg.PlatoCapComponentNgFactory, createInjector: clientInjector);
  }, onError: (e) {
    window.console.log ('Uncaught error:\n${e.toString()}');
  });
}
