import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Widget child;
  final Color borderColor;


  const ProfileAvatar(
      {Key? key,
      required this.imageUrl,
      required this.size,
      required this.child,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 3.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 2,
          child: child,
        ),
      ],
    );
  }
}
