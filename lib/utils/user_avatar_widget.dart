import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:creme_sharing/assets/fonts/app_fonts.dart';
import 'package:creme_sharing/assets/colors/app_colors.dart';

class UserAvatarWidget extends StatelessWidget {
  final Uint8List? avatarImageBytes;
  final String name;
  final Size avatarSize;
  final TextStyle? letterTextStyle;

  const UserAvatarWidget({
    Key? key,
    required this.name,
    required this.avatarSize,
    required this.letterTextStyle,
    required this.avatarImageBytes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstLetter = name.isNotEmpty ? name[0] : '';
    final avatarWithoutUrl = Container(
      height: avatarSize.height,
      width: avatarSize.width,
      decoration: const BoxDecoration(
        color: AppColors.avatarBackgroundColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        firstLetter.toUpperCase(),
        style: letterTextStyle ?? AppFonts.bodyBold.apply(color: Colors.white),
      ),
    );

    return ClipOval(
      child: SizedBox(
        height: avatarSize.height,
        width: avatarSize.width,
        child: Stack(
          children: [
            if (avatarImageBytes == null)
              Container(
                height: avatarSize.height,
                width: avatarSize.width,
                decoration: const BoxDecoration(
                  color: AppColors.avatarBackgroundColor,
                  shape: BoxShape.circle,
                ),
              ),
            if (avatarImageBytes != null)
              Align(
                alignment: Alignment.center,
                child: Image.memory(
                  avatarImageBytes!,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  height: avatarSize.height,
                  width: avatarSize.width,
                  alignment: Alignment.topCenter,
                  errorBuilder: (_, __, ___) => avatarWithoutUrl,
                ),
              ),
            if (avatarImageBytes == null)
              Align(
                alignment: Alignment.center,
                child: avatarWithoutUrl,
              ),
          ],
        ),
      ),
    );
  }
}
