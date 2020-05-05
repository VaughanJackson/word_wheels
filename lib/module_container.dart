import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:word_wheels/governor.dart';
import 'package:word_wheels/phrase_builder.dart';

// Main dependency injection configuration module.
class ModuleContainer {

  Injector initialise(Injector injector) {
    injector.map<PhraseBuilder>((injector) => PhraseBuilder());
    injector.mapWithParams<Governor>((injector, parameters) =>
        Governor(parameters['_onCharacterSelected']));
    return injector;
  }

}

final Injector injector = ModuleContainer().initialise(Injector.getInjector());
