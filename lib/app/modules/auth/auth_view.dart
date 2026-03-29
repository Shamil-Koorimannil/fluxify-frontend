import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import '../../../core/widgets/fluxify_input.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/values/app_values.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppValues.spacingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppValues.spacingXLarge * 2),

              // Logo/Brand Section
              _buildBrandSection(),

              const SizedBox(height: AppValues.spacingXLarge * 2),

              // Welcome Text
              _buildWelcomeText(),

              const SizedBox(height: AppValues.spacingXLarge),

              // Form Section
              _buildFormSection(),

              const SizedBox(height: AppValues.spacingLarge),

              // Action Button
              _buildActionButton(),

              const SizedBox(height: AppValues.spacingMedium),

              // Additional Options
              _buildAdditionalOptions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      children: [
        // Logo placeholder - replace with actual logo
        Container(
          width: Get.width * 0.3,
          height: Get.width * 0.3,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppValues.borderRadiusLarge),
          ),
          child: Icon(
            Icons.storefront,
            size: Get.width * 0.15,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: AppValues.spacingMedium),
        const Text(
          'Fluxify',
          style: TextStyle(
            fontSize: AppValues.fontSizeXXLarge,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const Text(
          'Social Discovery & Advertising',
          style: TextStyle(
            fontSize: AppValues.fontSizeMedium,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return Obx(() {
      final title = controller.authMode.value == AuthMode.emailPhone
          ? 'Welcome Back!'
          : 'Verify Your Number';
      final subtitle = controller.authMode.value == AuthMode.emailPhone
          ? 'Enter your email or phone number to continue'
          : 'Enter the 6-digit code sent to ${controller.emailPhoneController.text}';

      return Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppValues.fontSizeXXLarge,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppValues.spacingSmall),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppValues.fontSizeMedium,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildFormSection() {
    return Obx(() {
      if (controller.authMode.value == AuthMode.emailPhone) {
        return FluxifyInput(
          mode: FluxifyInputMode.emailPhone,
          controller: controller.emailPhoneController,
          focusNode: controller.emailPhoneFocusNode,
          textInputAction: TextInputAction.next,
          onSubmitted: (value) {
            if (controller.isEmailPhoneValid.value) {
              controller.sendOtp();
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter email or phone number';
            }
            if (!controller.isEmailPhoneValid.value) {
              return 'Please enter a valid email or phone number';
            }
            return null;
          },
        );
      } else {
        return Column(
          children: [
            FluxifyInput(
              mode: FluxifyInputMode.otp,
              controller: controller.otpController,
              focusNode: controller.otpFocusNode,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                if (controller.isOtpValid.value) {
                  controller.verifyOtp();
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter OTP';
                }
                if (!controller.isOtpValid.value) {
                  return 'Please enter a valid 6-digit OTP';
                }
                return null;
              },
            ),
            const SizedBox(height: AppValues.spacingMedium),
            _buildOtpTimerSection(),
          ],
        );
      }
    });
  }

  Widget _buildOtpTimerSection() {
    return Obx(() {
      if (controller.otpTimer.value > 0) {
        return Text(
          'Resend OTP in ${controller.otpTimer.value}s',
          style: const TextStyle(
            fontSize: AppValues.fontSizeSmall,
            color: AppTheme.textSecondary,
          ),
        );
      } else {
        return TextButton(
          onPressed: controller.resendOtp,
          child: const Text(
            'Resend OTP',
            style: TextStyle(
              fontSize: AppValues.fontSizeMedium,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }
    });
  }

  Widget _buildActionButton() {
    return Obx(() {
      final isLoading = controller.isLoading.value;
      final isEnabled = controller.authMode.value == AuthMode.emailPhone
          ? controller.isEmailPhoneValid.value
          : controller.isOtpValid.value;

      final buttonText = controller.authMode.value == AuthMode.emailPhone
          ? 'Send OTP'
          : 'Verify & Continue';

      return SizedBox(
        width: Get.width * AppValues.buttonWidthRatio,
        child: ElevatedButton(
          onPressed: isEnabled && !isLoading
              ? () {
                  if (controller.authMode.value == AuthMode.emailPhone) {
                    controller.sendOtp();
                  } else {
                    controller.verifyOtp();
                  }
                }
              : null,
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: AppValues.fontSizeMedium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      );
    });
  }

  Widget _buildAdditionalOptions() {
    return Obx(() {
      if (controller.authMode.value == AuthMode.otp) {
        return TextButton.icon(
          onPressed: () => controller.changeAuthMode(AuthMode.emailPhone),
          icon: const Icon(
            Icons.arrow_back,
            size: AppValues.iconSizeSmall,
            color: AppTheme.textSecondary,
          ),
          label: const Text(
            'Change Number',
            style: TextStyle(
              fontSize: AppValues.fontSizeMedium,
              color: AppTheme.textSecondary,
            ),
          ),
        );
      }

      return Column(
        children: [
          const SizedBox(height: AppValues.spacingLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: Get.width * 0.2,
                color: AppTheme.borderColor,
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppValues.spacingMedium),
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: AppValues.fontSizeSmall,
                    color: AppTheme.textTertiary,
                  ),
                ),
              ),
              Container(
                height: 1,
                width: Get.width * 0.2,
                color: AppTheme.borderColor,
              ),
            ],
          ),
          const SizedBox(height: AppValues.spacingLarge),
          SizedBox(
            width: Get.width * AppValues.buttonWidthRatio,
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Implement social login
                Get.snackbar(
                  'Coming Soon',
                  'Social login will be available soon',
                  backgroundColor: AppTheme.primaryColor,
                  colorText: Colors.white,
                );
              },
              icon: const Icon(
                Icons.g_mobiledata,
                size: AppValues.iconSizeMedium,
              ),
              label: const Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: AppValues.fontSizeMedium,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
