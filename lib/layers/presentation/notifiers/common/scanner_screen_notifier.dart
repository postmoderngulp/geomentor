import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolog/layers/presentation/pages/common/about_scanned.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:image_picker/image_picker.dart';

class ScannerScreenNotifier extends ChangeNotifier {
  XFile? file;
  Uint8List? bytes;

  void setGallery() async {
    ImagePicker picker = ImagePicker();
    file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file == null) return;
    bytes = await file!.readAsBytes();
    notifyListeners();
  }

  void setCamera() async {
    ImagePicker picker = ImagePicker();
    file = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (file == null) return;
    bytes = await file!.readAsBytes();
    notifyListeners();
  }

  void clearImage() {
    file = null;
    bytes = null;
    notifyListeners();
  }

  void scanning(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.w),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
          backgroundColor: Colors.grey.shade900,
          child: SizedBox(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                SizedBox(
                    width: 32.w,
                    height: 32.h,
                    child: CircularProgressIndicator(
                      color: MyColors.brandColor,
                    )),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
    int sec = 1;
    Timer.periodic(const Duration(seconds: 1), (val) {
      if (sec == 0) {
        val.cancel();
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AboutScanned()));
      }
      sec--;
    });
  }
}
