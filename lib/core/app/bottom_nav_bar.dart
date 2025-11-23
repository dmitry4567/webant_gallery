import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webant_gallery/core/app/app_router.dart';
import 'package:webant_gallery/core/theme/my_icons_icons.dart';
import 'package:webant_gallery/core/theme/palete.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AutoTabsScaffold(
            backgroundColor: Colors.transparent,
            routes: const [HomeRoute(), AllPhotosRoute(), ProfileRoute()],
            bottomNavigationBuilder: (_, tabsRouter) {
              return Container(
                color: AppColors.white,
                height: MediaQuery.of(context).padding.bottom + 48,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          tabsRouter.setActiveIndex(0);
                        },
                        child: SizedBox(
                          height: 48,
                          child: Icon(
                            MyIcons.home,
                            size: 21,
                            color: tabsRouter.activeIndex == 0
                                ? AppColors.main
                                : AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          tabsRouter.setActiveIndex(1);
                        },
                        child: SizedBox(
                          height: 48,
                          child: Icon(
                            MyIcons.camera,
                            size: 21,
                            color: tabsRouter.activeIndex == 1
                                ? AppColors.main
                                : AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          tabsRouter.setActiveIndex(2);
                        },
                        child: SizedBox(
                          height: 48,
                          child: Icon(
                            MyIcons.profile,
                            size: 21,
                            color: tabsRouter.activeIndex == 2
                                ? AppColors.main
                                : AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
