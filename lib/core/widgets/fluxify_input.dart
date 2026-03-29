import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../values/app_values.dart';

enum FluxifyInputMode { emailPhone, otp }

class FluxifyInput extends StatefulWidget {
  final FluxifyInputMode mode;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final bool enabled;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final EdgeInsets? contentPadding;

  const FluxifyInput({
    super.key,
    required this.mode,
    this.hintText,
    this.labelText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.textInputAction,
    this.autofocus = false,
    this.contentPadding,
  });

  @override
  State<FluxifyInput> createState() => _FluxifyInputState();
}

class _FluxifyInputState extends State<FluxifyInput> {
  late bool _obscureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double inputWidth = Get.width * AppValues.inputWidthRatio;

    return SizedBox(
      width: inputWidth,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: _getKeyboardType(),
        inputFormatters: _getInputFormatters(),
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        focusNode: _focusNode,
        textInputAction: widget.textInputAction,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        validator: widget.validator,
        style: const TextStyle(
          fontSize: AppValues.fontSizeMedium,
          color: AppTheme.textPrimary,
        ),
        decoration: _buildInputDecoration(),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    String hintText = widget.hintText ?? _getDefaultHintText();
    String? labelText = widget.labelText;

    Widget? prefixIcon = widget.prefixIcon ?? _getDefaultPrefixIcon();
    Widget? suffixIcon = widget.suffixIcon ?? _getDefaultSuffixIcon();

    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      counterText: '',
      filled: true,
      fillColor: widget.enabled
          ? AppTheme.surfaceColor
          : AppTheme.borderColor.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        borderSide: const BorderSide(
          color: AppTheme.borderColor,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        borderSide: BorderSide(
          color: _focusNode.hasFocus
              ? AppTheme.primaryColor
              : AppTheme.borderColor,
          width: _focusNode.hasFocus ? 2.0 : 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        borderSide: const BorderSide(
          color: AppTheme.primaryColor,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        borderSide: const BorderSide(
          color: AppTheme.errorColor,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        borderSide: const BorderSide(
          color: AppTheme.errorColor,
          width: 2.0,
        ),
      ),
      hintStyle: const TextStyle(
        color: AppTheme.textTertiary,
        fontSize: AppValues.fontSizeMedium,
      ),
      labelStyle: TextStyle(
        color: _focusNode.hasFocus
            ? AppTheme.primaryColor
            : AppTheme.textSecondary,
        fontSize: AppValues.fontSizeMedium,
      ),
    );
  }

  String _getDefaultHintText() {
    switch (widget.mode) {
      case FluxifyInputMode.emailPhone:
        return 'Enter email or phone number';
      case FluxifyInputMode.otp:
        return 'Enter 6-digit OTP';
    }
  }

  Widget? _getDefaultPrefixIcon() {
    switch (widget.mode) {
      case FluxifyInputMode.emailPhone:
        return Icon(
          Icons.person_outline,
          color: _focusNode.hasFocus
              ? AppTheme.primaryColor
              : AppTheme.textSecondary,
          size: AppValues.iconSizeMedium,
        );
      case FluxifyInputMode.otp:
        return Icon(
          Icons.lock_outline,
          color: _focusNode.hasFocus
              ? AppTheme.primaryColor
              : AppTheme.textSecondary,
          size: AppValues.iconSizeMedium,
        );
    }
  }

  Widget? _getDefaultSuffixIcon() {
    if (widget.mode == FluxifyInputMode.otp && widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppTheme.textSecondary,
          size: AppValues.iconSizeMedium,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return null;
  }

  TextInputType _getKeyboardType() {
    if (widget.keyboardType != null) return widget.keyboardType!;

    switch (widget.mode) {
      case FluxifyInputMode.emailPhone:
        return TextInputType.emailAddress;
      case FluxifyInputMode.otp:
        return TextInputType.number;
    }
  }

  List<TextInputFormatter> _getInputFormatters() {
    List<TextInputFormatter> formatters = [];

    if (widget.inputFormatters != null) {
      formatters.addAll(widget.inputFormatters!);
    }

    switch (widget.mode) {
      case FluxifyInputMode.otp:
        formatters.add(FilteringTextInputFormatter.digitsOnly);
        formatters.add(LengthLimitingTextInputFormatter(6));
        break;
      case FluxifyInputMode.emailPhone:
        // No additional formatters for email/phone
        break;
    }

    return formatters;
  }
}
