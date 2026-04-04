import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';

enum FluxifyInputStyle { dark, light }

class FluxifyInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
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
  final FluxifyInputStyle style;
  final double borderRadius;

  const FluxifyInput({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
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
    this.style = FluxifyInputStyle.light,
    this.borderRadius = 12.0,
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
    return SizedBox(
      width: widget.style == FluxifyInputStyle.light ? Get.width * 0.9 : null,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        focusNode: _focusNode,
        textInputAction: widget.textInputAction,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        validator: widget.validator,
        style: _getTextStyle(),
        decoration: _buildInputDecoration(),
      ),
    );
  }

  TextStyle _getTextStyle() {
    switch (widget.style) {
      case FluxifyInputStyle.dark:
        return const TextStyle(
          color: Colors.white,
          fontSize: 14,
        );
      case FluxifyInputStyle.light:
        return const TextStyle(
          fontSize: 14,
          color: AppTheme.textPrimary,
        );
    }
  }

  InputDecoration _buildInputDecoration() {
    Widget? suffixIcon = widget.suffixIcon;

    // Add password visibility toggle for dark style
    if (widget.style == FluxifyInputStyle.dark && widget.obscureText) {
      suffixIcon = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_outlined,
          color: Colors.white.withOpacity(0.6),
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    switch (widget.style) {
      case FluxifyInputStyle.dark:
        return InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: Colors.black,
          prefixIcon: widget.prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.8),
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
              color: AppTheme.darkError,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
              color: AppTheme.darkError,
              width: 2.0,
            ),
          ),
        );

      case FluxifyInputStyle.light:
        return InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          counterText: '',
          filled: true,
          fillColor: widget.enabled
              ? AppTheme.lightSurface
              : AppTheme.borderColor.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                const BorderSide(color: AppTheme.borderColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: _focusNode.hasFocus
                  ? AppTheme.primaryColor
                  : AppTheme.borderColor,
              width: _focusNode.hasFocus ? 2.0 : 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                const BorderSide(color: AppTheme.primaryColor, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                const BorderSide(color: AppTheme.lightError, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                const BorderSide(color: AppTheme.lightError, width: 2.0),
          ),
          hintStyle: const TextStyle(
            color: AppTheme.textTertiary,
            fontSize: 14,
          ),
          labelStyle: TextStyle(
            color: _focusNode.hasFocus
                ? AppTheme.primaryColor
                : AppTheme.textSecondary,
            fontSize: 14,
          ),
        );
    }
  }
}
