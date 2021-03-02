import 'package:flutter/widgets.dart';

class SyncScrollController {
  List<ScrollController> _registeredScrollControllers = new List<ScrollController>();

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  SyncScrollController([List<ScrollController> controllers]) {
    if (controllers != null) {
      controllers.forEach((controller) => registerScrollController(controller));
    }
  }

  double get scrollOffset {
    if (_registeredScrollControllers.isEmpty) return 0.0;

    final ScrollController controller = _registeredScrollControllers.firstWhere((c) => c.hasClients);
    if (controller == null) return 0.0;

    return controller.offset ?? 0.0;
  }

  void add(ScrollController controller) {
    registerScrollController(controller);
  }

  void remove(ScrollController controller) {
    _registeredScrollControllers.remove(controller);
  }

  void registerScrollController(ScrollController controller) {
    _registeredScrollControllers.add(controller);
  }

  void processNotification(ScrollNotification notification, ScrollController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        _registeredScrollControllers.forEach((controller) {
          if (!identical(_scrollingController, controller)) controller..jumpTo(_scrollingController.offset);
        });
        return;
      }
    }
  }
}
