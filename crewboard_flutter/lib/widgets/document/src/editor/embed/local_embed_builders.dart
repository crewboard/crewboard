
import 'dart:io';

import 'package:flutter/material.dart';


import './embed_editor_builder.dart';

class LocalImageEmbedBuilder extends EmbedBuilder {
  const LocalImageEmbedBuilder();

  @override
  String get key => 'image';

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    final String imageUrl = embedContext.node.value.data;
    if (userAgentCanHandle(imageUrl)) {
      // It's a URL
      return Image.network(imageUrl);
    } else {
      // It's likely a file path
      return Image.file(File(imageUrl));
    }
  }

  bool userAgentCanHandle(String url) {
    return url.startsWith('http') || url.startsWith('https');
  }
}

class LocalVideoEmbedBuilder extends EmbedBuilder {
  const LocalVideoEmbedBuilder();

  @override
  String get key => 'video';

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    final String videoUrl = embedContext.node.value.data;
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.black12,
      child: Center(
        child: Text('Video placeholder: $videoUrl'),
      ),
    );
  }
}
