import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_text_ocr/core/constants/colors.dart';
import 'package:image_to_text_ocr/features/home/presentation/pages/result_screen.dart';
import 'package:image_to_text_ocr/features/home/presentation/widgets/icon_button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            final image = await ImagePicker().pickImage(source: ImageSource.gallery);

          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: IconButtonWidget(
                        icon: CupertinoIcons.camera,
                        label: "Camera",
                        onTap: () {},
                      ),
                    ),
                    Gap(16),
                    Expanded(
                      child: IconButtonWidget(
                        icon: CupertinoIcons.photo,
                        label: "Gallery",
                        onTap: () async {
                          final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            final CroppedFile? croppedFile =
                                await ImageCropper().cropImage(sourcePath: image.path, uiSettings: [
                              AndroidUiSettings(
                                  toolbarTitle: 'Crop',
                                  cropGridColor: Colors.black,
                                  initAspectRatio: CropAspectRatioPreset.original,
                                  lockAspectRatio: false),
                              IOSUiSettings(title: 'Crop')
                            ]);
                            if (croppedFile != null) {
                              print("Path:" + croppedFile.path);
                              context.push(ResultScreen(croppedFile: croppedFile));
                            }
                          }
                          // context.push(ResultScreen(imagePath: ''));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
