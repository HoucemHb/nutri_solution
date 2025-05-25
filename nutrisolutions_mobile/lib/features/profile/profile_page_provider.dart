import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the current page index
final currentPageProvider = StateProvider<int>((ref) => 0);

/// Provider for the PageController
final pageControllerProvider = Provider<PageController>((ref) {
  final controller = PageController();

  // Listen to page changes and update the currentPageProvider
  controller.addListener(() {
    final page = controller.page?.round();
    if (page != null && ref.read(currentPageProvider.notifier).state != page) {
      ref.read(currentPageProvider.notifier).state = page;
    }
  });

  return controller;
});