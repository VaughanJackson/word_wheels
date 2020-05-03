import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:word_wheels/governor.dart';
import 'package:word_wheels/phrase_builder.dart';

// Similar to a Spring test configuration?
class TestModuleContainer {

  Injector initialise(Injector injector) {
    injector.map<PhraseBuilder>((injector) => PhraseBuilder());
    injector.mapWithParams<Governor>((injector, parameters) =>
        Governor(parameters['_onCharacterSelected']));
    return injector;
  }

}

final Injector injector = TestModuleContainer().initialise(Injector.getInjector());
