import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluxify/core/theme/app_text_styles.dart';
import 'package:fluxify/core/widgets/customText.dart';
import '../constants/app_colors.dart';
import '../../app/modules/home/home_controller.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(
          color: AppColors.white24,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info section
          _buildUserInfo(),

          // Post image
          _buildPostImage(),

          // Actions section
          _buildActions(),

          // Likes and caption
          _buildPostDetails(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          // Profile image
          Container(
            width: 35.w,
            height: 35.w,
            decoration: BoxDecoration(
              color: AppColors.white24,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: post.userProfileImage.startsWith('assets')
                  ? Image.asset(
                      post.userProfileImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          color: AppColors.white70,
                          size: 16.w,
                        );
                      },
                    )
                  : Icon(
                      Icons.person,
                      color: AppColors.white70,
                      size: 16.w,
                    ),
            ),
          ),

          SizedBox(width: 12.w),

          // Username
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: post.username, style: AppTextStyles.subheading),
                Text(
                  "location",
                  style: AppTextStyles.body,
                )
              ],
            ),
          ),

          // More options
          Icon(
            Icons.more_horiz,
            color: AppColors.white,
            size: 20.w,
          ),
        ],
      ),
    );
  }

  Widget _buildPostImage() {
    return Container(
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
        color: AppColors.white24,
      ),
      child: post.image.startsWith('assets')
          ? Image.asset(
              post.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.image,
                    color: AppColors.white54,
                    size: 48.w,
                  ),
                );
              },
            )
          : Center(
              child: Icon(
                Icons.image,
                color: AppColors.white54,
                size: 48.w,
              ),
            ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          // Like button
          GestureDetector(
            onTap: onLike,
            child: Icon(
              post.isLiked ? Icons.favorite : Icons.favorite_border,
              color: post.isLiked ? Colors.red : AppColors.white,
              size: 24.w,
            ),
          ),

          SizedBox(width: 16.w),

          // Comment button
          Icon(
            Icons.comment_outlined,
            color: AppColors.white,
            size: 24.w,
          ),

          SizedBox(width: 16.w),

          // Share button
          Icon(
            Icons.send_outlined,
            color: AppColors.white,
            size: 24.w,
          ),

          const Spacer(),

          // Save button
          Icon(
            Icons.bookmark_border,
            color: AppColors.white,
            size: 24.w,
          ),
        ],
      ),
    );
  }

  Widget _buildPostDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Likes count
          Text(
            '${post.likes} likes',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 4.h),

          // Caption
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: post.username,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' ${post.caption}',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 4.h),

          // Comments
          GestureDetector(
            onTap: () {
              // TODO: Navigate to comments
            },
            child: Text(
              'View all ${post.comments} comments',
              style: TextStyle(
                color: AppColors.white54,
                fontSize: 14.sp,
              ),
            ),
          ),

          SizedBox(height: 4.h),

          // Timestamp
          Text(
            post.timestamp,
            style: TextStyle(
              color: AppColors.white54,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
