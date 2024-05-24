import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_to_text_ocr/core/constants/text_strings.dart';
import 'package:image_to_text_ocr/features/home/presentation/manager/text_recognizer/text_recognizer_cubit.dart';
import 'package:image_to_text_ocr/features/home/presentation/pages/edit_screen.dart';
import 'package:image_to_text_ocr/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:skeletonizer/skeletonizer.dart';

class ResultScreen extends StatefulWidget {
  final CroppedFile croppedFile;

  const ResultScreen({super.key, required this.croppedFile});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // final String textToSave = "Hello, this is some text to save.";

  String convertDateTimeNowToText() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-ddHH-mm-ss');
    final String formatted = formatter.format(now);
    return formatted;
  }

  Future<void> saveAsTxt(String textToSave) async {
    try {
      final Directory directory = await getTemporaryDirectory();
      final String fileName = '${convertDateTimeNowToText()}.txt';
      final File file = File('${directory.path}\\$fileName')..createSync();
      await file.writeAsString(textToSave);
      print('Text saved as .txt file at ${file.path}');
    } catch (e) {
      print('Error saving .txt file: $e');
    }
  }

  Future<void> saveAsPdf(String textToSave) async {
    try {
      print(textToSave);
      Directory? directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) directory = await getExternalStorageDirectory();
      final String fileName = '${convertDateTimeNowToText()}.pdf';
      final File file = File('${directory?.path}/$fileName');
      final pdfLib.Document pdf = pdfLib.Document();
      pdf.addPage(pdfLib.Page(build: (pdfLib.Context context) => pdfLib.Text(textToSave)));
      await file.writeAsBytes(await pdf.save());
      print('Text saved as PDF file at ${file.path}');
    } catch (e) {
      print('Error saving PDF file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextRecognizerCubit()..loadText(widget.croppedFile),
      child: BlocBuilder<TextRecognizerCubit, TextRecognizerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text(S.of(context).details)),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<TextRecognizerCubit, TextRecognizerState>(
                builder: (context, state) {
                  if (state.status.isFailure) {
                    return const Center(
                      child: Text("Failed to recognize text"),
                    );
                  }
                  return Skeletonizer(
                    enabled: state.status.isInProgress,
                    child: Text(
                      //   lorem
                      state.status.isInProgress ? AppTexts.resultLorem : state.recognizedText?.text ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.start,
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                print("Edit");
                // context.push(EditScreen());
              },
              child: Icon(Icons.edit),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
            bottomNavigationBar: BottomAppBar(
              // padding: EdgeInsets.zero,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: state.status.isFailure
                        ? null
                        : () async {
                            print("copied");
                            await Clipboard.setData(ClipboardData(text: state.recognizedText?.text ?? ""));
                          },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed:
                        state.status.isFailure ? null : () async => await Share.share(state.recognizedText?.text ?? ""),
                  ),
                  IconButton(
                    icon: Icon(Icons.translate),
                    onPressed: state.status.isFailure ? null : () {},
                  ),
                  PopupMenuButton(
                    offset: Offset(0, -120),
                    itemBuilder: (context) {
                      return [
                        //   save as txt or pdf
                        PopupMenuItem(
                          value: 'txt',
                          onTap: state.status.isFailure
                              ? null
                              : () async => await saveAsTxt(state.recognizedText?.text ?? ""),
                          child: Row(
                            children: [
                              Icon(Icons.text_snippet),
                              Gap(8),
                              Text(S.of(context).textFile),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'pdf',
                          onTap: state.status.isFailure
                              ? null
                              : () async {
                                  print(state.recognizedText?.text);
                                  await saveAsPdf(state.recognizedText?.text ?? "");
                                },
                          child: Row(
                            children: [
                              Icon(Icons.picture_as_pdf),
                              Gap(8),
                              Text(S.of(context).pdfFile),
                            ],
                          ),
                        ),
                      ];
                    },
                    icon: Icon(Icons.save),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
