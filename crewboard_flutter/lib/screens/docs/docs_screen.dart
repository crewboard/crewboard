import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'flows/flows_controller.dart';
import 'flows/flows.dart';
import 'document_editor.dart';
import 'docs_sidebar.dart';

class DocsScreen extends ConsumerWidget {
  const DocsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowsState = ref.watch(flowsProvider);

    // Show Flows or DocumentEditor based on current subpage
    if (flowsState.currentSubPage == FlowSubPage.flows) {
      return const Flows();
    } else {
      return const DocumentEditor();
    }
  }
}
