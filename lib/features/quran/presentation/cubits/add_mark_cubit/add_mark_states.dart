abstract class AddMarkState{}

class AddMarkInitialState extends AddMarkState{}

class AddMarkLoadingState extends AddMarkState{}

class AddMarkSuccessState extends AddMarkState{}

class AddMarkErrorState extends AddMarkState{
  final String message;

  AddMarkErrorState(this.message);
}