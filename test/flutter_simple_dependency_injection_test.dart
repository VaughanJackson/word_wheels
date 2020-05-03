// Example provided for the flutter simple dependency injection package.
// See https://pub.dev/packages/flutter_simple_dependency_injection.

import 'package:flutter/cupertino.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

void main() {
  // it is best to place all injector initialisation work into one or more modules
  // so it can act more like a dependency injector than a service locator
  final injector = ModuleContainer().initialise(Injector.getInjector());

  // NOTE: it is best to architect your code so that you never need to
  // interact with the injector itself.  Make this framework act like a dependency injector
  // by having dependencies injected into objects in their constructors.  That way you avoid
  // any tight coupling with the injector itself.

  // Basic usage, however this kind of tight couple and direct interaction with the injector
  // should be limited.  Instead prefer dependencies injection.

  // simple dependency retrieval and method call
  injector.get<SomeService>().doSomething();

  // get an instance of each of the same mapped types
  final instances = injector.getAll<SomeType>();
  print(instances.length); // prints '3'

  // passing in additional arguments when getting an instance
  final instance =
  injector.get<SomeOtherType>(additionalParameters: {"id": "some-id"});
  print(instance.id); // prints 'some-id'

  // VJ - Example added by myself to verify that a callback can be passed to
  //      an injected class instance.
  final injectedInstance = injector.get<ClassTakingCallback>(
      additionalParameters: {"_callback":
          () { print('Callback provided by client!'); }});
  injectedInstance.callCallback(); // 'Callback provided by client!' printed out

  // VJ - Example added by myself to verify that a callback can be passed to
  //      an injected class instance.
  final injectedInstanceWithComplexCallback =
  injector.get<ClassTakingCallbackWithParameter>(
      additionalParameters: {"_callback":
          (parameter) {
        print('Callback provided by client! Parameter = ' + parameter); }});
  injectedInstanceWithComplexCallback.callCallback('你好'); // 'Callback provided by client! Parameter = 你好' printed out
}

class ModuleContainer {
  Injector initialise(Injector injector) {
    injector.map<Logger>((i) => Logger(), isSingleton: true);
    injector.map<String>((i) => "https://api.com/", key: "apiUrl");
    injector.map<SomeService>(
            (i) => SomeService(i.get<Logger>(), i.get<String>(key: "apiUrl")));

    injector.map<SomeType>((injector) => SomeType("0"));
    injector.map<SomeType>((injector) => SomeType("1"), key: "One");
    injector.map<SomeType>((injector) => SomeType("2"), key: "Two");

    injector.mapWithParams<SomeOtherType>((i, p) => SomeOtherType(p["id"]));

    // VJ - Example added by myself to verify that a callback can be passed to
    //      an injected class instance.
    injector.mapWithParams<ClassTakingCallback>(
            (injector, parameters) => ClassTakingCallback(parameters["_callback"]));

    // VJ - Example added by myself to verify that a callback can be passed to
    //      an injected class instance.
    injector.mapWithParams<ClassTakingCallbackWithParameter>(
            (injector, parameters) => ClassTakingCallbackWithParameter(parameters["_callback"]));

    return injector;
  }
}

class Logger {
  void log(String message) => print(message);
}

class SomeService {
  final Logger _logger;
  final String _apiUrl;

  SomeService(this._logger, this._apiUrl);

  void doSomething() {
    _logger.log("Doing something with the api at '$_apiUrl'");
  }
}

class SomeType {
  final String id;
  SomeType(this.id);
}

class SomeOtherType {
  final String id;
  SomeOtherType(this.id);
}

// VJ - Example added by myself to verify that a callback can be passed to
//      an injected class instance.
class ClassTakingCallback {
  final VoidCallback _callback;

  ClassTakingCallback(this._callback);

  void callCallback() {
    _callback();
  }
}

// VJ - Example added by myself to verify that a callback can be passed to
//      an injected class instance.
class ClassTakingCallbackWithParameter {
  final ValueSetter<String> _callback;

  ClassTakingCallbackWithParameter(this._callback);

  void callCallback(String parameter) {
    _callback(parameter);
  }
}
