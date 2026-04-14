import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/palette.dart';

class SidebarState {
  final bool isOpen;
  final bool closeOnExit;
  final CurrentPage currentPage;
  final String subPage;

  SidebarState({
    this.isOpen = true,
    this.closeOnExit = false,
    this.currentPage = CurrentPage.chat,
    this.subPage = '',
  });

  SidebarState copyWith({
    bool? isOpen,
    bool? closeOnExit,
    CurrentPage? currentPage,
    String? subPage,
  }) {
    return SidebarState(
      isOpen: isOpen ?? this.isOpen,
      closeOnExit: closeOnExit ?? this.closeOnExit,
      currentPage: currentPage ?? this.currentPage,
      subPage: subPage ?? this.subPage,
    );
  }
}

final sidebarProvider = NotifierProvider<SidebarNotifier, SidebarState>(SidebarNotifier.new);

class SidebarNotifier extends Notifier<SidebarState> {
  @override
  SidebarState build() => SidebarState();

  void toggleSidebar() {
    state = state.copyWith(isOpen: !state.isOpen);
  }

  void openSidebar() {
    state = state.copyWith(isOpen: true);
  }

  void closeSidebar() {
    state = state.copyWith(isOpen: false);
  }

  void navigate(CurrentPage page) {
    state = state.copyWith(currentPage: page);
  }

  void setSubPage(String subPage) {
    state = state.copyWith(subPage: subPage);
  }
}
