import 'package:flutter/material.dart';
import 'package:fluxify/core/services/screen_services.dart';
import 'package:fluxify/core/theme/app_text_styles.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/fluxify_next_button.dart';
import '../../routes/app_pages.dart';
import 'auth_controller.dart';

class OtpVerificationView extends GetView<AuthController> {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: context.screen.h(15),),
              // Logo Section
              Image.asset(
                AppImages.logo,
                width: Get.width * 0.5,
                fit: BoxFit.contain,
              ),

              SizedBox(height: context.screen.h(20),),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal:  context.screen.w(10),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification',
                      style: AppTextStyles.heading,
                    ),

                    // Subtitle
                    Text(
                        'Enter Your OTP  To Verify Your Account. ',
                        style: AppTextStyles.body
                    ),

                    SizedBox(height: context.screen.h(3.5),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildOtpBox(context.screen.w(10), context.screen.h(5)),
                        _buildOtpBox(context.screen.w(10), context.screen.h(5)),
                        _buildOtpBox(context.screen.w(10), context.screen.h(5)),
                        _buildOtpBox(context.screen.w(10), context.screen.h(5)),
                        _buildOtpBox(context.screen.w(10), context.screen.h(5)),
                        _buildOtpBox(context.screen.w(10), context.screen.h(5)),
                      ],
                    ),

                    SizedBox(height: context.screen.h(3.5),),

                    // Login Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() => FluxifyNextButton(
                          onTap: () =>
                              Get.toNamed(AppRoutes.home),
                          isLoading: controller.isLoading.value,
                        )),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.screen.h(20),),
              // Resend Code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code? ",
                    style: AppTextStyles.body,
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    child: Text(
                      'Resend',
                      style: AppTextStyles.body,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(double w , double h) {

    return SizedBox(
      width: w,
      height: h,
      child: TextField(
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: AppTextStyles.body,
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.lightBackground,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.lightBackground,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppColors.white.withValues(alpha: 0.05),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            // Move to next field
            FocusScope.of(Get.context!).nextFocus();
          }
        },
      ),
    );
  }
}
