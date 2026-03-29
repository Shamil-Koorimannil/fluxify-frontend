import 'package:flutter/material.dart';

class FluxifyNextButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;
  final bool isEnabled;
  final String text;
  final double? width;
  final double height;

  const FluxifyNextButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
    this.isEnabled = true,
    this.text = 'NEXT',
    this.width, // If null, it will wrap the text
    this.height = 30.0, // Matches your design height
  }) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isEnabled && !isLoading) ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5, // Dims the button if disabled
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(height / 2), // Perfect Pill Shape
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Shrinks to fit text
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const SizedBox(
                  height: 14,
                  width: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              else ...[
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11, // Standard small bold font from your design
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: 16,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}