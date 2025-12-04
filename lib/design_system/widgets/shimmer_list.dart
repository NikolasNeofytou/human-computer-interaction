import 'package:flutter/material.dart';

import '../../theme/tokens.dart';
import 'shimmer_box.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, __) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadii.md),
          boxShadow: AppShadows.level1,
          border: Border.all(color: AppColors.neutral.withOpacity(0.1)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(height: 16, width: 180),
            SizedBox(height: AppSpacing.sm),
            ShimmerBox(height: 14, width: 120),
          ],
        ),
      ),
    );
  }
}
