import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vital_health/app/onboarding/onboarding_state.dart';
import 'package:vital_health/core/repositories/motivational_message_repository.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  MotivationalMessageRepository repository;
  final int totalPages = 3; // Total number of onboarding pages

  OnboardingCubit(this.repository)
      : super(OnboardingState(currentPage: 0, messages: []));

// Load messages from the JSON file
  Future<void> loadMessages() async {
    try {
      final messages = await repository.fetchMessages();
      emit(state.copyWith(messages: messages));
    } catch (e) {
      emit(state.copyWith(
          messages: ["Error loading messages. Please try again later."]));
    }
  }

  // Update the current page
  void setPage(int pageIndex) {
    emit(state.copyWith(currentPage: pageIndex));
  }

  // Move to the previous page
  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  // Move to the next page
  void nextPage() {
    if (state.currentPage < totalPages - 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  // Skip to the last page
  void skip() {
    // emit(state.copyWith(currentPage: totalPages - 1));
  }
}
