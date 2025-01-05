import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vital_health/app/journaling/journaling_screen.dart';
import 'package:vital_health/app/onboarding/onboarding_cubit.dart';
import 'package:vital_health/app/onboarding/onboarding_state.dart';
import 'package:vital_health/core/repositories/motivational_message_repository.dart';
import 'package:vital_health/utils/widgets/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            OnboardingCubit(MotivationalMessageRepository())..loadMessages(),
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final cubit = context.read<OnboardingCubit>();
            final images = [
              'assets/images/onboarding1.png',
              'assets/images/onboarding2.png',
              'assets/images/onboarding3.png',
            ];

            return SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: OnboardingPage(
                  key: ValueKey<int>(state
                      .currentPage), // Ensures a new widget is created on page change
                  description: state.messages.isNotEmpty
                      ? state.messages[state.currentPage]
                      : "Loading...",
                  imagePath: images[state.currentPage],
                  currentIndex: state.currentPage,
                  onBack:
                      state.currentPage > 0 ? () => cubit.previousPage() : null,
                  // onNext: () => cubit.nextPage(),
                  onNext: () {
                    if (state.currentPage < cubit.totalPages - 1) {
                      cubit.nextPage();
                    } else {
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (_) {
                        return const JournalingScreen();
                      }));
                    }
                  },

                  onSkip: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return const JournalingScreen();
                    }));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
