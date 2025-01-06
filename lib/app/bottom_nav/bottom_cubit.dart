import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vital_health/app/bottom_nav/bottom_state.dart';
import 'package:vital_health/utils/enums.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit()
      : super(BottomNavState(index: 0, selectedItem: NavbarItem.dashboard));

  void getNavBar(NavbarItem item) {
    switch (item) {
      case NavbarItem.dashboard:
        emit(BottomNavState(index: 0, selectedItem: NavbarItem.dashboard));
        break;
      case NavbarItem.journal:
        emit(BottomNavState(index: 1, selectedItem: NavbarItem.journal));
        break;
    }
  }
}
