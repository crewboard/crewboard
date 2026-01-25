
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

class FlowEmbedBuilder extends EmbedBuilder {
  const FlowEmbedBuilder();

  @override
  String get key => 'flow';

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    // data should be a json string or map containing flow info
    // For simplicity, let's assume it's "Flow Name" or a JSON string.
    String flowName = "Unknown Flow";
    if (embedContext.node.value.data is String) {
       flowName = embedContext.node.value.data;
       try {
         // If we decide to pass JSON later
         // final data = jsonDecode(embedContext.node.value.data);
         // flowName = data['name'];
       } catch (_) {}
    }

    return Card(
      child: ListTile(
        leading: const Icon(Icons.account_tree_outlined), // Flow chart icon
        title: Text(flowName),
        subtitle: const Text("Flow Chart"),
        trailing: const Icon(Icons.open_in_new),
        onTap: () {
          // TODO: Open flow viewer/editor
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Opening flow: $flowName")),
          );
        },
      ),
    );
  }
}
