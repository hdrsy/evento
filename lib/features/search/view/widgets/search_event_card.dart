import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class SearchEventCard extends StatelessWidget {
  const SearchEventCard({super.key,
  required this.date,
  required this.title,
  required this.imgUrl,
  });
final String imgUrl;
final String title;
final String date;
  @override
  Widget build(BuildContext context) {
    return    Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imgUrl,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: customTextStyle.bodyMedium,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Text(
                      date,
                      style: customTextStyle.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
  

  }
}