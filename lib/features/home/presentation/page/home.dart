import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_gallery/core/theme/font.dart';
import 'package:webant_gallery/core/theme/my_icons_icons.dart';
import 'package:webant_gallery/core/theme/palete.dart';
import 'package:webant_gallery/core/utils/toast.dart';
import 'package:webant_gallery/features/home/data/repository/photo_query_factory.dart';
import 'package:webant_gallery/features/home/presentation/cubit/home_cubit.dart';
import 'package:webant_gallery/features/home/presentation/widgets/photo_gridview_widget.dart';
import 'package:webant_gallery/injection_container.dart' as di;

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    di.sl<ToastService>().init(context);

    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() {
        _selectedIndex = controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Column(
          children: [
            Container(
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                cursorWidth: 1,
                cursorHeight: 17,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 4),
                    child: Icon(MyIcons.search, size: 14),
                  ),
                  prefixIconConstraints: BoxConstraints(),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greySecondary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  contentPadding: const EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 18, right: 18),
            child: TabBar(
              indicatorWeight: 2,
              dividerHeight: 2,
              labelPadding: EdgeInsets.symmetric(horizontal: 0),
              indicatorColor: AppColors.main,
              dividerColor: AppColors.greyLight,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: AppColors.main, width: 2.0),
              ),
              controller: controller,
              tabs: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    "New",
                    style: AppTextStyle.h3.copyWith(
                      color: _selectedIndex == 0
                          ? AppColors.black
                          : AppColors.grey,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    "Popular",
                    style: AppTextStyle.h3.copyWith(
                      color: _selectedIndex == 1
                          ? AppColors.black
                          : AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TabBarView(
                controller: controller,
                children: [
                  BlocProvider(
                    create: (context) =>
                        di.sl<HomeCubit>(param1: PhotoType.newPhoto),
                    child: const PhotosGridView(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                  ),
                  BlocProvider(
                    create: (context) =>
                        di.sl<HomeCubit>(param1: PhotoType.popularPhoto),
                    child: const PhotosGridView(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
