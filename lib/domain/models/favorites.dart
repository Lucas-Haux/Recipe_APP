import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class Favorites {
  const Favorites({
    required int id,
    required int date,
  });
}
