abstract class OnBoardingStates {}

class OnBoardingInitState extends OnBoardingStates {}

class OnBoardingLoadingState extends OnBoardingStates {}

class OnBoardingSuccessState extends OnBoardingStates {}

class OnBoardingFailureState extends OnBoardingStates {
  String errorMessage;
  OnBoardingFailureState({required this.errorMessage});
}
