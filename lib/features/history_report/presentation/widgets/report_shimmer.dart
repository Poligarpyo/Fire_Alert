import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/theme/app_theme.dart';

class ReportShimmer extends StatelessWidget {
  const ReportShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: context.responsiveValue(small: 4, medium: 6, large: 8),
        horizontal: context.responsiveValue(small: 8, medium: 12, large: 16),
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 8, medium: 10, large: 12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          context.responsiveValue(small: 12, medium: 16, large: 20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder shimmer
            ClipRRect(
              borderRadius: BorderRadius.circular(
                context.responsiveValue(small: 6, medium: 8, large: 10),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: context.responsiveValue(small: 120, medium: 150, large: 180),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: context.responsiveValue(small: 8, medium: 12, large: 16),
            ),
            // Type badge and location shimmer
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: context.responsiveValue(small: 40, medium: 50, large: 60),
                    height: context.responsiveValue(small: 16, medium: 20, large: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        context.responsiveValue(small: 4, medium: 6, large: 8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.responsiveValue(small: 6, medium: 8, large: 10),
                ),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: context.responsiveValue(small: 14, medium: 16, large: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          context.responsiveValue(small: 2, medium: 3, large: 4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.responsiveValue(small: 4, medium: 6, large: 8),
            ),
       
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: context.responsiveValue(small: 12, medium: 14, large: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        context.responsiveValue(small: 2, medium: 3, large: 4),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveValue(small: 4, medium: 6, large: 8),
                  ),
                  Container(
                    width: context.responsiveValue(small: 200, medium: 250, large: 300),
                    height: context.responsiveValue(small: 12, medium: 14, large: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        context.responsiveValue(small: 2, medium: 3, large: 4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.responsiveValue(small: 6, medium: 8, large: 10),
            ),
   
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: context.responsiveValue(small: 40, medium: 50, large: 60),
                    height: context.responsiveValue(small: 16, medium: 20, large: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        context.responsiveValue(small: 4, medium: 6, large: 8),
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: context.responsiveValue(small: 80, medium: 100, large: 120),
                    height: context.responsiveValue(small: 12, medium: 14, large: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        context.responsiveValue(small: 2, medium: 3, large: 4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReportsListShimmer extends StatelessWidget {
  const ReportsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(
        context.responsiveValue(small: 12, medium: 16, large: 20),
      ),
      itemCount: 5, 
      itemBuilder: (context, index) {
        return const ReportShimmer();
      },
    );
  }
}
