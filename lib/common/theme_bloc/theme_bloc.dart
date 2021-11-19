import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeData: ThemeData.light(), themeModel: "light")) {
    on<EventResetTheme>((event, emit) {
      emit.call(state.copyWith(
          themeModel: event.state.themeModel,
          themeData: event.state.themeData));
    });
  }
}
