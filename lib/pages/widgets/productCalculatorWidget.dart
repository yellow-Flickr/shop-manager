// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_manager/models/ShopModel.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({
    Key? key,
    required this.theme,
    required this.item,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  final ThemeData theme;
  final Product item;
  final Color? backgroundColor, textColor;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ListTile(
        leading: CircleAvatar(
          radius: height * 0.03,
          backgroundColor: backgroundColor ?? theme.primaryColorLight,
          child: (item.imageb64 ?? "").isEmpty
              ? Center(
                  child: Text(
                    item.productName!.substring(0, 2).toUpperCase(),
                    style: theme.textTheme.headline1!
                        .copyWith(fontSize: 20, color: textColor??theme.primaryColor),
                  ),
                )
              : Container(
                  // width: width * 0.45,
                  // height: height * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.1),
                      image: DecorationImage(
                          image: MemoryImage(base64Decode(item.imageb64!)),
                          fit: BoxFit.cover)),
                ),
        ),
        title: Text(item.productName!,
            style: theme.textTheme.bodyText2!
                .copyWith(color: textColor ?? Colors.white)),
        subtitle: Text("GHS ${item.sellingPrice}",
            style: theme.textTheme.bodyText2!
                .copyWith(fontSize: 12, color: textColor ?? Colors.white)));
  }
}
