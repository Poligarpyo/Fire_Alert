import 'package:flutter/material.dart';
import 'shimmer/shimmer_loading_widget.dart';
import '../../../../shared/theme/app_theme.dart';

class GpsContainerSection extends StatefulWidget {
  const GpsContainerSection({super.key});

  @override
  State<GpsContainerSection> createState() => _GpsContainerSectionState();
}

class _GpsContainerSectionState extends State<GpsContainerSection> {
  String _currentLocation = 'Fetching location...';
  String _address = 'Getting address...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    setState(() {
      _currentLocation = '14.5995° N, 120.9842° E';
      _address = 'Manila, Metro Manila, Philippines';
      _isLoading = false;
    });
  }

  void refreshLocation() async {
    setState(() {
      _isLoading = true;
      _currentLocation = 'Refreshing location...';
      _address = 'Getting updated address...';
    });

    await Future<void>.delayed(const Duration(seconds: 2));

    setState(() {
      _currentLocation = '14.5995° N, 120.9842° E';
      _address = 'Manila, Metro Manila, Philippines';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 8, medium: 12, large: 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(
              context.responsiveValue(small: 10, medium: 12, large: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Current Location (GPS)',
                    style: context
                        .responsiveH3(
                          fontSizeSmall: 12,
                          fontSizeMedium: 14,
                          fontSizeLarge: 16,
                        )
                        .copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.textPrimaryColor,
                        ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveValue(
                      small: 5,
                      medium: 6,
                      large: 8,
                    ),
                    vertical: context.responsiveValue(
                      small: 2,
                      medium: 3,
                      large: 4,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: _isLoading ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _isLoading ? 'Loading' : 'Live',
                    style: context
                        .responsiveBodyText(
                          fontSizeSmall: 8,
                          fontSizeMedium: 10,
                          fontSizeLarge: 12,
                          color: context.textWhiteColor,
                        )
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: context.responsiveValue(
              small: 130,
              medium: 170,
              large: 200,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: context.responsiveValue(
                small: 10,
                medium: 12,
                large: 16,
              ),
            ),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(
                context.responsiveValue(small: 6, medium: 8, large: 10),
              ),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: _isLoading
                ? ShimmerLoadingWidget(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        context.responsiveValue(small: 4, medium: 6, large: 8),
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: context.surfaceColor,
                          borderRadius: BorderRadius.circular(
                            context.responsiveValue(
                              small: 6,
                              medium: 8,
                              large: 10,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Map View',
                            style: context.responsiveBodyText(
                              fontSizeSmall: 12,
                              fontSizeMedium: 14,
                              fontSizeLarge: 16,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.location_on,
                          color: AppTheme.primaryRed,
                          size: context.responsiveIconSize(
                            small: 30,
                            medium: 36,
                            large: 48,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.responsiveValue(
                              small: 5,
                              medium: 6,
                              large: 8,
                            ),
                            vertical: context.responsiveValue(
                              small: 2,
                              medium: 3,
                              large: 4,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(
                              context.responsiveValue(
                                small: 3,
                                medium: 4,
                                large: 5,
                              ),
                            ),
                          ),
                          child: Text(
                            '+/- 5m',
                            style: context.responsiveBodyText(
                              fontSizeSmall: 8,
                              fontSizeMedium: 10,
                              fontSizeLarge: 12,
                              color: context.textWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),

          Padding(
            padding: EdgeInsets.all(
              context.responsiveValue(small: 10, medium: 12, large: 16),
            ),
            child: _isLoading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerTextWidget(
                        width: context.responsiveValue(
                          small: 180,
                          medium: 200,
                          large: 250,
                        ),
                        height: context.responsiveValue(
                          small: 10,
                          medium: 12,
                          large: 14,
                        ),
                      ),
                      SizedBox(
                        height: context.responsiveValue(
                          small: 2,
                          medium: 3,
                          large: 4,
                        ),
                      ),
                      ShimmerTextWidget(
                        width: context.responsiveValue(
                          small: 130,
                          medium: 150,
                          large: 180,
                        ),
                        height: context.responsiveValue(
                          small: 8,
                          medium: 10,
                          large: 12,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentLocation,
                        style: context
                            .responsiveBodyText(
                              fontSizeSmall: 10,
                              fontSizeMedium: 12,
                              fontSizeLarge: 14,
                              color: context.textPrimaryColor,
                            )
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: context.responsiveValue(
                          small: 2,
                          medium: 3,
                          large: 4,
                        ),
                      ),
                      Text(
                        _address,
                        style: context.responsiveBodyText(
                          fontSizeSmall: 8,
                          fontSizeMedium: 10,
                          fontSizeLarge: 12,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
