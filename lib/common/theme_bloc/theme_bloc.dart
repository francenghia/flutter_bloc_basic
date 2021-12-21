import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_basic/flutter_bloc_basic.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required ThemeState defaultTheme}) : super(defaultTheme) {
    on<EventResetTheme>((event, emit) {
      emit.call(state.copyWith(
          themeModel: event.state.themeModel,
          themeData: event.state.themeData));
    });
  }
}
