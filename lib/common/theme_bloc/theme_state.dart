part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  /// 主题数据
  final ThemeData themeData;

  final String themeModel;

  const ThemeState({required this.themeData, required this.themeModel});

  @override
  List<Object?> get props => [themeData, themeModel];

  ThemeState copyWith({ThemeData? themeData, String? themeModel}) {
    return ThemeState(
        themeData: themeData ?? this.themeData,
        themeModel: themeModel ?? this.themeModel);
  }
}
