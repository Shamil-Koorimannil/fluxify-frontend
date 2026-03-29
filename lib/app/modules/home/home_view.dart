import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import 'home_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/post_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isLoading.value && controller.posts.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppConstants.whiteColor,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.refreshPosts(),
          color: AppConstants.whiteColor,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return PostCard(
                post: post,
                onLike: () => controller.toggleLike(post.id),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: Obx(() => BottomNavigation(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
          )),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppConstants.backgroundColor,
      elevation: 0,
      title: Obx(() =>
          controller.isSearching.value ? _buildSearchBar() : _buildLogo()),
      centerTitle: false,
      actions: [
        Obx(() {
          if (!controller.isSearching.value) {
            return Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: AppConstants.whiteColor,
                    size: 24.w,
                  ),
                  onPressed: controller.toggleSearch,
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: AppConstants.whiteColor,
                    size: 24.w,
                  ),
                  onPressed:() => Get.toNamed(Routes.AUTH),
                ),
              ],
            );
          } else {
            return IconButton(
              icon: Icon(
                Icons.close,
                color: AppConstants.whiteColor,
                size: 24.w,
              ),
              onPressed: controller.toggleSearch,
            );
          }
        }),
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 100.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.asset(
          AppConstants.logoPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        color: AppConstants.white24Color,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: TextField(
        autofocus: true,
        style: TextStyle(
          color: AppConstants.whiteColor,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(
            color: AppConstants.white70Color,
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppConstants.white70Color,
            size: 20.w,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 8.h,
          ),
        ),
        onChanged: controller.onSearchChanged,
      ),
    );
  }
}
