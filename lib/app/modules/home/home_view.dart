import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluxify/core/constants/app_colors.dart';
import 'package:fluxify/core/constants/app_images.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import 'home_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/bottom_navigation.dart';
import '../../../core/widgets/post_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isLoading.value && controller.posts.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.refreshPosts(),
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: buildFeedList(),
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
      backgroundColor: AppColors.lightBackground,
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
                    color: AppColors.white,
                    size: 24.w,
                  ),
                  onPressed: controller.toggleSearch,
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 24.w,
                  ),
                  onPressed:() => Get.toNamed(AppRoutes.auth),
                ),
              ],
            );
          } else {
            return IconButton(
              icon: Icon(
                Icons.close,
                color: AppColors.white,
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
          AppImages.logo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        color: AppColors.white24,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: TextField(
        autofocus: true,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(
            color: AppColors.white70,
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.white70,
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

  Widget buildFeedList(){
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemCount: controller.posts.length,
      itemBuilder: (context, index) {
        final post = controller.posts[index];
        return PostCard(
          post: post,
          onLike: () => controller.toggleLike(post.id),
        );
      },
    );
  }
}
