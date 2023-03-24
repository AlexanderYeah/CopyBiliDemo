import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedImage(String url, {double? width, double? height}) {
  return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: ((context, url) => Container(
            color: Colors.grey[200],
          )),
      errorWidget: ((context, url, error) => Icon(Icons.error)));
}

// 底部的阴影
BoxDecoration bottomBoxShadow() {
  return BoxDecoration(color: Colors.white, boxShadow: [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(0, 5), // xy轴的便宜
      blurRadius: 5.0, // 阴影模糊程度
      spreadRadius: 1, // 阴影扩散程度
    )
  ]);
}
