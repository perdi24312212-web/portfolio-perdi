import 'package:flutter/material.dart';

import '../theme.dart';

bool isWide(BuildContext context) => MediaQuery.sizeOf(context).width >= 900;

/// Membatasi lebar konten agar nyaman dibaca di layar lebar.
class Content extends StatelessWidget {
  final Widget child;
  const Content({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: child,
        ),
      ),
    );
  }
}

class SectionBlock extends StatelessWidget {
  final String title;
  final Widget child;
  final bool divider;
  const SectionBlock({
    super.key,
    required this.title,
    required this.child,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Content(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (divider) const Divider(color: AppColors.line, height: 1),
          const SizedBox(height: 48),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w800, color: AppColors.navy),
          ),
          const SizedBox(height: 10),
          Container(width: 40, height: 4, color: AppColors.gold),
          const SizedBox(height: 28),
          child,
          const SizedBox(height: 56),
        ],
      ),
    );
  }
}
