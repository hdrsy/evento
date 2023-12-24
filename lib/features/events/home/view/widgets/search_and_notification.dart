import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class SearchAndNotification extends StatelessWidget {
  const SearchAndNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding(0,10,5,0),
      height: scaleHeight(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
Expanded(child: searchTextField(onChanged: (value){})),
SizedBox(width: scaleWidth(20),),
Icon(
  Icons.notifications_none_outlined,
  color: customColors.secondaryText,
  size: 30,
)

        ],
      ),
    );
  }
}