import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../modules/home/home_controller.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;

  const PostCard({
    Key? key,
    required this.post,
    required this.onLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        border: Border.all(
          color: AppConstants.white24Color,
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
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: AppConstants.white24Color,
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
                          color: AppConstants.white70Color,
                          size: 16.w,
                        );
                      },
                    )
                  : Icon(
                      Icons.person,
                      color: AppConstants.white70Color,
                      size: 16.w,
                    ),
            ),
          ),
          
          SizedBox(width: 8.w),
          
          // Username
          Expanded(
            child: Text(
              post.username,
              style: TextStyle(
                color: AppConstants.whiteColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // More options
          Icon(
            Icons.more_horiz,
            color: AppConstants.whiteColor,
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
        color: AppConstants.white24Color,
      ),
      child: post.image.startsWith('assets')
          ? Image.asset(
              post.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.image,
                    color: AppConstants.white54Color,
                    size: 48.w,
                  ),
                );
              },
            )
          : Center(
              child: Icon(
                Icons.image,
                color: AppConstants.white54Color,
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
              color: post.isLiked ? Colors.red : AppConstants.whiteColor,
              size: 24.w,
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Comment button
          Icon(
            Icons.comment_outlined,
            color: AppConstants.whiteColor,
            size: 24.w,
          ),
          
          SizedBox(width: 16.w),
          
          // Share button
          Icon(
            Icons.send_outlined,
            color: AppConstants.whiteColor,
            size: 24.w,
          ),
          
          const Spacer(),
          
          // Save button
          Icon(
            Icons.bookmark_border,
            color: AppConstants.whiteColor,
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
              color: AppConstants.whiteColor,
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
                    color: AppConstants.whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' ${post.caption}',
                  style: TextStyle(
                    color: AppConstants.whiteColor,
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
                color: AppConstants.white54Color,
                fontSize: 14.sp,
              ),
            ),
          ),
          
          SizedBox(height: 4.h),
          
          // Timestamp
          Text(
            post.timestamp,
            style: TextStyle(
              color: AppConstants.white54Color,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
