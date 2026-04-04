// import 'package:flutter/material.dart';
//
// class UIHelper {
//   // Spacing utilities
//   static Widget verticalSpace(double height) {
//     return SizedBox(height: height);
//   }
//
//   static Widget horizontalSpace(double width) {
//     return SizedBox(width: width);
//   }
//
//   static const Widget verticalSpaceSmall = SizedBox(height: 8);
//   static const Widget verticalSpaceMedium = SizedBox(height: 16);
//   static const Widget verticalSpaceLarge = SizedBox(height: 24);
//
//   static const Widget horizontalSpaceSmall = SizedBox(width: 8);
//   static const Widget horizontalSpaceMedium = SizedBox(width: 16);
//   static const Widget horizontalSpaceLarge = SizedBox(width: 24);
//
//   // Divider utilities
//   static Widget divider({double? height, Color? color, double? thickness}) {
//     return Divider(
//       height: height,
//       color: color ?? Colors.grey[300],
//       thickness: thickness ?? 1,
//     );
//   }
//
//   static Widget verticalDivider({double? width, Color? color, double? thickness}) {
//     return VerticalDivider(
//       width: width,
//       color: color ?? Colors.grey[300],
//       thickness: thickness ?? 1,
//     );
//   }
//
//   // Loading utilities
//   static Widget showLoading({Color? color}) {
//     return Center(
//       child: CircularProgressIndicator(
//         color: color,
//       ),
//     );
//   }
//
//   static Widget showLoadingOverlay({bool isLoading = false, Widget? child}) {
//     if (!isLoading && child != null) return child;
//
//     return Stack(
//       children: [
//         if (child != null) child,
//         if (isLoading)
//           Container(
//             color: Colors.black54,
//             child: showLoading(),
//           ),
//       ],
//     );
//   }
//
//   // Common widgets
//   static Widget buildHeader(
//     String title, {
//     TextStyle? textStyle,
//     TextAlign? textAlign,
//     int? maxLines,
//     TextOverflow? overflow,
//   }) {
//     return Text(
//       title,
//       style: textStyle ?? const TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//       ),
//       textAlign: textAlign,
//       maxLines: maxLines,
//       overflow: overflow,
//     );
//   }
//
//   static Widget buildSubHeader(
//     String title, {
//     TextStyle? textStyle,
//     TextAlign? textAlign,
//     int? maxLines,
//     TextOverflow? overflow,
//   }) {
//     return Text(
//       title,
//       style: textStyle ?? const TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.w500,
//       ),
//       textAlign: textAlign,
//       maxLines: maxLines,
//       overflow: overflow,
//     );
//   }
//
//   static Widget buildBodyText(
//     String text, {
//     TextStyle? textStyle,
//     TextAlign? textAlign,
//     int? maxLines,
//     TextOverflow? overflow,
//   }) {
//     return Text(
//       text,
//       style: textStyle ?? const TextStyle(
//         fontSize: 16,
//       ),
//       textAlign: textAlign,
//       maxLines: maxLines,
//       overflow: overflow,
//     );
//   }
//
//   static Widget buildCaption(
//     String text, {
//     TextStyle? textStyle,
//     TextAlign? textAlign,
//     int? maxLines,
//     TextOverflow? overflow,
//   }) {
//     return Text(
//       text,
//       style: textStyle ?? const TextStyle(
//         fontSize: 14,
//         color: Colors.grey,
//       ),
//       textAlign: textAlign,
//       maxLines: maxLines,
//       overflow: overflow,
//     );
//   }
//
//   // Card utilities
//   static Widget buildCard({
//     Widget? child,
//     EdgeInsetsGeometry? margin,
//     EdgeInsetsGeometry? padding,
//     double? elevation,
//     Color? color,
//     double? borderRadius,
//     VoidCallback? onTap,
//   }) {
//     return Container(
//       margin: margin,
//       child: Card(
//         elevation: elevation ?? 4,
//         color: color,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius ?? 12),
//         ),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(borderRadius ?? 12),
//           child: Padding(
//             padding: padding ?? const EdgeInsets.all(16),
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Button utilities
//   static Widget buildElevatedButton(
//     String text,
//     VoidCallback onPressed, {
//     Color? backgroundColor,
//     Color? foregroundColor,
//     double? borderRadius,
//     EdgeInsetsGeometry? padding,
//     double? width,
//     double? height,
//   }) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           foregroundColor: foregroundColor ?? Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius ?? 12),
//           ),
//           padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         ),
//         child: Text(text),
//       ),
//     );
//   }
//
//   static Widget buildOutlinedButton(
//     String text,
//     VoidCallback onPressed, {
//     Color? borderColor,
//     Color? foregroundColor,
//     double? borderRadius,
//     EdgeInsetsGeometry? padding,
//     double? width,
//     double? height,
//   }) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: OutlinedButton(
//         onPressed: onPressed,
//         style: OutlinedButton.styleFrom(
//           side: BorderSide(color: borderColor ?? Colors.blue),
//           foregroundColor: foregroundColor ?? Colors.blue,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius ?? 12),
//           ),
//           padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         ),
//         child: Text(text),
//       ),
//     );
//   }
//
//   // Image utilities
//   static Widget buildNetworkImage(
//     String imageUrl, {
//     double? width,
//     double? height,
//     BoxFit? fit,
//     Widget? placeholder,
//     Widget? errorWidget,
//   }) {
//     return Image.network(
//       imageUrl,
//       width: width,
//       height: height,
//       fit: fit ?? BoxFit.cover,
//       loadingBuilder: (context, child, loadingProgress) {
//         if (loadingProgress == null) return child;
//         return placeholder ?? showLoading();
//       },
//       errorBuilder: (context, error, stackTrace) {
//         return errorWidget ?? _buildErrorWidget();
//       },
//     );
//   }
//
//   static Widget _buildErrorWidget() {
//     return Container(
//       color: Colors.grey[300],
//       child: const Icon(
//         Icons.error_outline,
//         color: Colors.grey,
//         size: 40,
//       ),
//     );
//   }
// }
