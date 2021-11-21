import '../flutter_bloc_basic.dart';

typedef ConverterResponseFromJsonOnSuccess = Function(
    Map<String, dynamic> json);

typedef ConverterResponseFromJsonOnFailed = Function(BaseException e);

typedef CreateGlobalBlocProviders = List<BlocProvider> Function();

typedef CreateRepositoryProviders = List<RepositoryProvider> Function();
