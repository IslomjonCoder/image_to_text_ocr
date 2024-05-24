import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:meta/meta.dart';

part 'text_recognizer_state.dart';

class TextRecognizerCubit extends Cubit<TextRecognizerState> {
  final TextRecognizer recognizer = TextRecognizer();

  TextRecognizerCubit() : super(TextRecognizerState());

  Future<void> recognizeText(String imagePath) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final InputImage image = InputImage.fromFilePath(imagePath);
    final RecognizedText recognizedText = await recognizer.processImage(image);
    emit(state.copyWith(recognizedText: RecognizedText(text: recognizedText.text, blocks: recognizedText.blocks), status: FormzSubmissionStatus.success));
  }

  void loadText(CroppedFile croppedFile) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final InputImage image = InputImage.fromFilePath(croppedFile.path);
    final RecognizedText recognizedText = await recognizer.processImage(image);
    emit(state.copyWith(recognizedText: RecognizedText(text: recognizedText.text, blocks: recognizedText.blocks), status: FormzSubmissionStatus.success));
  }
}
