abstract class BaseResponseConverter<T> {
  Future<T> convertFromJson<T>(json);
}
