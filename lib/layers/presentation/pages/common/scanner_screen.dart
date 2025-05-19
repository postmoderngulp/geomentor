import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolog/layers/presentation/notifiers/common/scanner_screen_notifier.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';
import 'package:provider/provider.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScannerScreenNotifier(),
      child: const SubScannerScreen(),
    );
  }
}

class SubScannerScreen extends StatelessWidget {
  const SubScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    'Распознование растения',
                    style: MyFontStyle.subMainTitle,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Scan(),
                SizedBox(
                  height: 50.h,
                ),
                const Row(
                  children: [GalleryButton(), Spacer(), CameraButton()],
                ),
                SizedBox(
                  height: 20.h,
                ),
                const ScanButton(),
                SizedBox(
                  height: 20.h,
                ),
                const ClearButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Scan extends StatelessWidget {
  const Scan({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ScannerScreenNotifier>();
    return Center(
      child: notifier.bytes != null
          ? Container(
              width: 350.w,
              height: 300.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade900),
                  image: DecorationImage(
                      image: MemoryImage(notifier.bytes as Uint8List),
                      fit: BoxFit.cover),
                  color: Colors.grey.shade900,
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
            )
          : Container(
              width: 350.w,
              height: 300.h,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: Text(
                  'Пусто',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
            ),
    );
  }
}

class GalleryButton extends StatelessWidget {
  const GalleryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ScannerScreenNotifier>();
    return Center(
      child: SizedBox(
        width: 150.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () => notifier.setGallery(),
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(MyColors.brandColor),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            'Галерея',
            style: MyFontStyle.subTitleBlack,
          ),
        ),
      ),
    );
  }
}

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ScannerScreenNotifier>();
    return Center(
      child: SizedBox(
        width: 350.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () =>
              notifier.bytes == null ? null : notifier.scanning(context),
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(MyColors.brandColor),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            'Сканировать',
            style: MyFontStyle.subTitleBlack,
          ),
        ),
      ),
    );
  }
}

class ClearButton extends StatelessWidget {
  const ClearButton({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ScannerScreenNotifier>();
    return Center(
      child: SizedBox(
        width: 350.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () => notifier.clearImage(),
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade800),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            'Очистить',
            style: MyFontStyle.subTitle,
          ),
        ),
      ),
    );
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ScannerScreenNotifier>();
    return Center(
      child: SizedBox(
        width: 150.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () => notifier.setCamera(),
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(MyColors.brandColor),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            'Камера',
            style: MyFontStyle.subTitleBlack,
          ),
        ),
      ),
    );
  }
}
