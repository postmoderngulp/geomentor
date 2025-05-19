// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolog/layers/presentation/pages/common/viewing_screen.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:provider/provider.dart';
import 'package:geolog/layers/presentation/notifiers/common/about_plant_notifier.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';

// ignore: must_be_immutable
class AboutPlant extends StatelessWidget {
  int plant;
  AboutPlant({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AboutPlantNotifier(favoritePlant: plant),
      child: const SubAboutStone(),
    );
  }
}

class SubAboutStone extends StatelessWidget {
  const SubAboutStone({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AboutPlantNotifier>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: notifier.plant == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Center(
                      child: CircularProgressIndicator(
                    color: MyColors.brandColor,
                  )),
                  const Spacer()
                ],
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          width: 400.w,
                          height: 400.h,
                          child: Center(
                            child: BabylonJSViewer(
                              src:
                                  'https://ybtmhmcuudcbiojupcnw.supabase.co/storage/v1/object/public/models//${notifier.plant?.model}',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w, top: 16.h),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 30.w,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 315.h),
                          child: Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ViewingScreen(
                                              model: notifier.plant!.model,
                                            ))),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.w, top: 16.h),
                                  child: SvgPicture.asset(
                                      'assets/image/explore.svg'),
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.name_ru,
                        style: MyFontStyle.mainTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Латинское название:',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.name_latin.toString(),
                        style: MyFontStyle.littleSubTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Род:',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.genus == null
                            ? "Не определён"
                            : notifier.genus,
                        style: MyFontStyle.littleSubTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Происхождение:',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.origin,
                        style: MyFontStyle.littleSubTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Семейство:',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.family == null
                            ? "Не определено"
                            : notifier.family,
                        style: MyFontStyle.littleSubTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Среда обитания:',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.habitat == null
                            ? "Не определено"
                            : notifier.habitat,
                        style: MyFontStyle.littleSubTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Тип растения:',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.plant_type == null
                            ? "Не определено"
                            : notifier.plant_type,
                        style: MyFontStyle.littleSubTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Источник:',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.source == null
                            ? "Не определено"
                            : notifier.plant!.source.toString(),
                        style: MyFontStyle.littleSubTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Жизненный цикл',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.life_cycle == null
                            ? "Не определено"
                            : notifier.life_cycle,
                        style: MyFontStyle.littleSubTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
