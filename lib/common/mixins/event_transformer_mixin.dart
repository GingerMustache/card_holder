import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

mixin EventTransformerMixin {
  EventTransformer<BlocEventAbstract> debounceRestartable<BlocEventAbstract>() {
    return (events, mapper) => restartable<BlocEventAbstract>().call(
      events.debounceTime(const Duration(milliseconds: 300)),
      mapper,
    );
  }
}
