import 'dart:ui';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:creme_sharing/assets/fonts/app_fonts.dart';
import 'package:creme_sharing/assets/colors/app_colors.dart';

class UserAvatarWidget extends StatelessWidget {
  final Uint8List? avatarImageBytes;
  final String? emoji;
  final TextStyle? emojiTextStyle;
  final String name;
  final Size avatarSize;
  final TextStyle? letterTextStyle;
  final double? textScaleFactor;
  late final String firstLetter;
  final AlignmentGeometry? avatarImageAlignment;

  UserAvatarWidget({
    Key? key,
    required this.name,
    this.avatarImageBytes,
    this.emoji,
    this.emojiTextStyle,
    this.avatarSize = const Size(40, 40),
    this.letterTextStyle,
    this.textScaleFactor,
    this.avatarImageAlignment,
  }) : super(key: key) {
    firstLetter = name.isNotEmpty ? name[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: avatarSize.height,
          width: avatarSize.width,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              if (avatarImageBytes != null)
                Align(
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: Image.memory(
                      avatarImageBytes!,
                      height: avatarSize.height,
                      width: avatarSize.width,
                      fit: BoxFit.cover,
                      alignment: avatarImageAlignment ?? Alignment.center,
                      errorBuilder: (context, error, stackTrace) =>
                          _AvatarWithoutImageWidget(
                        firstLetter: firstLetter,
                        textScaleFactor: textScaleFactor,
                        letterTextStyle: letterTextStyle,
                        avatarSize: avatarSize,
                      ),
                    ),
                  ),
                ),
              if (avatarImageBytes == null)
                _AvatarWithoutImageWidget(
                  firstLetter: firstLetter,
                  textScaleFactor: textScaleFactor,
                  letterTextStyle: letterTextStyle,
                  avatarSize: avatarSize,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarWithoutImageWidget extends StatelessWidget {
  final String firstLetter;
  final double? textScaleFactor;
  final TextStyle? letterTextStyle;
  final Size avatarSize;

  const _AvatarWithoutImageWidget({
    Key? key,
    required this.firstLetter,
    required this.textScaleFactor,
    required this.letterTextStyle,
    required this.avatarSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: SizedBox(
          height: avatarSize.height,
          width: avatarSize.width,
          child: Container(
            height: avatarSize.height,
            width: avatarSize.width,
            decoration: const BoxDecoration(
              color: AppColors.white10,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              firstLetter.toUpperCase(),
              textAlign: TextAlign.center,
              style: letterTextStyle ??
                  AppFonts.bodyBold.apply(color: Colors.white),
              textScaleFactor: textScaleFactor,
            ),
          ),
        ),
      ),
    );
  }
}
