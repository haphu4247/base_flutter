// import 'package:cinema/app/base/models/base_entity.dart';
// import 'package:hive/hive.dart';
//
// enum LocalDatabaseType { account, settings }
//
// extension LocalDatabaseTypeExt on LocalDatabaseType {
//   String _getName() {
//     return this.name;
//   }
//
//   Future<void> save<T extends BaseEntity<T>>(
//     T value,
//   ) async {
//     final box = await Hive.openBox<T>(_getName());
//     await box.add(value);
//     await box.close();
//   }
//
//   Future<void> close() async {
//     if (Hive.isBoxOpen(_getName())) {
//       await Hive.close();
//     }
//   }
//
//   Future<Box<E>> open<E>() async {
//     if (Hive.isBoxOpen(_getName())) {
//       return Hive.box<E>(_getName());
//     }
//     return Hive.openBox<E>(_getName());
//   }
//
//   Future<Iterable<T>> read<T extends BaseEntity<T>>() async {
//     final box = await Hive.openBox<T>(_getName());
//     final result = box.values;
//     await box.close();
//     return result;
//   }
// }
