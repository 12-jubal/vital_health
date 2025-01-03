// Define the state class
class OnboardingState {
  final int currentPage;
  final List<String> messages;

  OnboardingState({required this.currentPage, required this.messages});

  // Create a copy of the state for immutability
  OnboardingState copyWith({int? currentPage, List<String>? messages}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      messages: messages ?? this.messages,
    );
  }
}
