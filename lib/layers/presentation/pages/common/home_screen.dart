// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:geolog/layers/presentation/notifiers/common/home_notifier.dart';
import 'package:geolog/layers/presentation/pages/common/about_plant.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeNotifier(),
      child: const SubHomeScreen(),
    );
  }
}

class SubHomeScreen extends StatefulWidget {
  const SubHomeScreen({super.key});

  @override
  State<SubHomeScreen> createState() => _SubHomeScreenState();
}

class _SubHomeScreenState extends State<SubHomeScreen>
    with AutomaticKeepAliveClientMixin<SubHomeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 34.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    'Растения',
                    style: MyFontStyle.mainTitle,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                const PLants(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PLants extends StatelessWidget {
  const PLants({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<HomeNotifier>();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: notifier.isLoading ? 5 : notifier.plants.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: notifier.isLoading
            ? const ShimmerPlantsItem()
            : PLantsItem(index: index),
      ),
    );
  }
}

// ignore: must_be_immutable
class PLantsItem extends StatelessWidget {
  int index;
  PLantsItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<HomeNotifier>();
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutPlant(
                plant: notifier.plants[index].id,
              ))),
      child: Column(
        children: [
          Container(
            width: 300.w,
            height: 140.h,
            decoration: BoxDecoration(
                color: MyColors.brandColor,
                image: DecorationImage(
                    image: NetworkImage("https://ybtmhmcuudcbiojupcnw.supabase.co/storage/v1/object/public/images//${notifier.plants[index].image}"),
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
          ),
          Container(
            width: 300.w,
            height: 55.h,
            decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  notifier.plants[index].name_ru,
                  style: MyFontStyle.littleSubTitle,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => notifier.favorites.any(
                          (item) => item.plant_id == notifier.plants[index].id)
                      ? notifier.removeFavorite(notifier.plants[index])
                      : notifier.addFavorite(notifier.plants[index]),
                  child: SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: SvgPicture.asset(
                        'assets/image/favorite.svg',
                        colorFilter: ColorFilter.mode(
                            notifier.favorites.any((item) =>
                                    item.plant_id == notifier.plants[index].id)
                                ? MyColors.brandColor
                                : Colors.grey.shade500,
                            BlendMode.srcIn),
                      )),
                ),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerPlantsItem extends StatelessWidget {
  const ShimmerPlantsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: MyColors.brandColor,
          highlightColor: MyColors.subBrandColor,
          child: Container(
            width: 300.w,
            height: 140.h,
            decoration: BoxDecoration(
                color: MyColors.brandColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
          ),
        ),
        Container(
          width: 300.w,
          height: 55.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              Shimmer.fromColors(
                  baseColor: MyColors.brandColor,
                  highlightColor: MyColors.subBrandColor,
                  child: Container(
                    width: 80.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(5)),
                  )),
              const Spacer(),
              SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: SvgPicture.asset(
                    'assets/image/favorite.svg',
                    colorFilter:
                        ColorFilter.mode(Colors.grey.shade900, BlendMode.srcIn),
                  )),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
