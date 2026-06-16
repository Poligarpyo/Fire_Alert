import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/theme/app_theme.dart';

class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({
    super.key,
    this.size,
    this.icon,
    this.backgroundImage,
    this.onImageSelected,
  });
  final double? size;
  final IconData? icon;
  final String? backgroundImage;
  final void Function(String)? onImageSelected;

  @override
  Widget build(BuildContext context) {
    final double avatarSize =
        size ?? context.responsiveValue(small: 80, medium: 100, large: 120);

    return GestureDetector(
      onTap: () => _showImagePicker(context),
      child: Stack(
        children: <Widget>[
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              color: context.textWhiteColor,
              borderRadius: BorderRadius.circular(avatarSize / 2),
              border: Border.all(color: context.primaryColor, width: 3),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: backgroundImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(avatarSize / 2),
                    child: Image.network(
                      backgroundImage!,
                      width: avatarSize,
                      height: avatarSize,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) {
                            return Icon(
                              icon ?? Icons.person,
                              size: avatarSize * 0.5,
                              color: context.primaryColor,
                            );
                          },
                    ),
                  )
                : Icon(
                    icon ?? Icons.person,
                    size: avatarSize * 0.5,
                    color: context.primaryColor,
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: avatarSize * 0.3,
              height: avatarSize * 0.3,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.circular(avatarSize * 0.15),
                border: Border.all(color: context.textWhiteColor, width: 2),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.camera_alt,
                size: avatarSize * 0.15,
                color: context.textWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showImagePicker(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text(
                'Select Photo',
                style: context.responsiveH3(
                  fontSizeSmall: 18,
                  fontSizeMedium: 20,
                  fontSizeLarge: 22,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageOption(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                  _buildImageOption(
                    context,
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: context.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(icon, size: 30, color: context.primaryColor),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: context.responsiveBodyText(
              fontSizeSmall: 12,
              fontSizeMedium: 14,
              fontSizeLarge: 16,
              color: context.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null && onImageSelected != null) {
        // Validate file size (max 5MB)
        final file = await image.readAsBytes();
        if (file.length > 5 * 1024 * 1024) {
          debugPrint('Image file too large: ${file.length} bytes');
          return;
        }
        onImageSelected!(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }
}
