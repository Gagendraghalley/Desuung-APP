// reusable_widgets.dart
import 'package:flutter/material.dart';

class CopyrightText extends StatelessWidget {
  final bool showDivider;
  final EdgeInsetsGeometry? padding;
  
  const CopyrightText({
    super.key,
    this.showDivider = true,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final theme = Theme.of(context);
    
    return Container(
      padding: padding,
      child: Column(
        children: [
          if (showDivider) ...[
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 16),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.copyright,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 4),
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  children: [
                    TextSpan(text: '$currentYear De-suung. '),
                    const TextSpan(
                      text: 'All rights reserved.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Made with ❤️ for Bhutan',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}