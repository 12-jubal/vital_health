import 'package:vital_health/utils/enums.dart';

class BottomNavState {
  final int index;
  final NavbarItem selectedItem;

  BottomNavState({
    required this.index,
    required this.selectedItem,
  });

  BottomNavState copyWith({
    int? index,
    NavbarItem? item,
  }) {
    return BottomNavState(
      index: index ?? this.index,
      selectedItem: selectedItem,
    );
  }
}
