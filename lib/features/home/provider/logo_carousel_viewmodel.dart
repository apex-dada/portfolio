import 'dart:async';
import 'package:flutter/material.dart';

class LogoCarouselViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  Timer? _timer;

  void initialize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent / 2);
        _startAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (scrollController.hasClients) {
        final currentScroll = scrollController.offset;
        final maxScroll = scrollController.position.maxScrollExtent;
        
        double nextScroll = currentScroll + 0.6;
        if (nextScroll >= maxScroll - 100) {
          nextScroll = maxScroll / 2;
        }
        scrollController.jumpTo(nextScroll);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    scrollController.dispose();
    super.dispose();
  }
}
