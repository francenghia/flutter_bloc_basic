part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {}

class EventResetTheme extends ThemeEvent {
  final ThemeState state;

  @override
  List<Object?> get props => [state];

  EventResetTheme(this.state);
}
