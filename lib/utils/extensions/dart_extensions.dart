extension NullableStringX on String? {
  String validate({String value = ''}) {
    return isEmptyOrNull ? value : this!;
  }

  /// Returns true if given String is null or isEmpty
  bool get isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this! == 'null');
}

extension NulluableIntX on int? {
  int validate({int value = 0}) {
    return this ?? value;
  }
}

extension NullableBoolX on bool? {
  bool validate({bool value = false}) => this ?? value;
}

/// Extensions for nullable [double].
extension NullableDoubleX on double? {
  double validate({double value = 0.0}) => this ?? value;
}

extension ListExt<T> on List<T> {
  int get lastIndex => length - 1;
  int get size => length;
  void addFirst(T t) => insert(0, t);
  List<T> toUnmodified() => List.unmodifiable(this);
}
