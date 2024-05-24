part of 'text_recognizer_cubit.dart';

 class TextRecognizerState {
   final FormzSubmissionStatus status;
   final RecognizedText? recognizedText;
   const TextRecognizerState({
     this.status = FormzSubmissionStatus.initial,
     this.recognizedText,
   });

   TextRecognizerState copyWith({
     FormzSubmissionStatus? status,
     RecognizedText? recognizedText,
   }) {
     return TextRecognizerState(
       status: status ?? this.status,
       recognizedText: recognizedText ?? this.recognizedText,
     );
   }
 }


