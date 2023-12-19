import 'package:flutter/widgets.dart';

extension ListWidgetExt on List<Widget> {
  List<Widget> separator(Widget Function(int index) creator) {
    if (this.length < 2) return this;
    final List<Widget> newList = List.from(this);
    final int length = this.length;
    for (var i = length - 2; i >= 0; i--) {
      newList.insert(i + 1, creator.call(i));
    }

    return newList;
  }
}

extension ListExt<T> on List<T> {
  List<T> removedWhere(bool Function(T element) test) {
    removeWhere(test);

    return this;
  }

  /// Remove duplicate objects in a List
  ///
  /// This function takes O(n^2) complexity
  /// so the length of the List should be <= 1000
  /// for the best performance
  List<T> removeDuplicatesBy<K>(
    K Function(T element) keyOf,
  ) {
    final List<T> result = [];
    for (int i = 0; i < length; i++) {
      final currentElement = this[i];
      bool isContains = false;
      for (int j = 0; j < result.length; j++) {
        if (keyOf(currentElement) == keyOf(result[j])) {
          isContains = true;
          break;
        }
      }
      if (!isContains) result.add(currentElement);
    }

    return result;
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
        <K, List<E>>{},
        (Map<K, List<E>> map, E element) =>
            map..putIfAbsent(keyFunction(element), () => <E>[]).add(element),
      );

  Iterable<T> compactMap<T>(T? Function(E e) toElement) {
    try {
      return (map((e) => toElement(e)).toList()..removeWhere((e) => e == null))
          .map((e) => e!);
    } catch (e, _) {
      return [];
    }
  }
}

extension SafeLookup<E> on List<E> {
  E? get(int index) {
    try {
      return this[index];
    } on RangeError {
      return null;
    }
  }
}

extension SafeLookupNull<E> on List<E>? {
  E? get(int index) {
    try {
      return this?[index];
    } on RangeError {
      return null;
    }
  }
}

extension ListEnumsX on List<Enum> {
  bool containValue(Enum value) {
    final listValue = map((e) => e.name).toList();

    return listValue.contains(value.name);
  }
}

// extension ListAccountX on List<Account> {
//   // Calculate total balance of all accounts
//   double get totalBalance {
//     return map((account) => double.parse(account.balance ?? '0'))
//         .fold(0, (a, b) => a + b);
//   }

//   // Get currencyCode
//   String get currencyCode {
//     final first = firstWhere(
//       (element) => element.currencyCode != null,
//       orElse: () => const Account(),
//     );
//     return first.currencyCode ?? 'MYR';
//   }
// }
