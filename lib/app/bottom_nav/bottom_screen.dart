import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vital_health/app/bottom_nav/bottom_cubit.dart';
import 'package:vital_health/app/bottom_nav/bottom_state.dart';
import 'package:vital_health/app/dashboard/dashboard_screen.dart';
import 'package:vital_health/app/journaling/journaling_screen.dart';
import 'package:vital_health/utils/enums.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BottomNavCubit(),
        child: BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) {
            return Scaffold(
              body: state.selectedItem == NavbarItem.dashboard
                  ? DashboardScreen()
                  : JournalingScreen(),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.index,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context
                          .read<BottomNavCubit>()
                          .getNavBar(NavbarItem.dashboard);
                      break;
                    case 1:
                      context
                          .read<BottomNavCubit>()
                          .getNavBar(NavbarItem.journal);
                      break;
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: 'Journal',
                  ),
                ],
              ),
            );
          },
        ));
  }
}
