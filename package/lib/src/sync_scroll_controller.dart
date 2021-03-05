import 'package:flutter/widgets.dart';

/// Controls a synchronous scrollable widgets through their scroll controllers.
///
/// Can be used implicitly by wrapping multiple scrollable widgets in
/// the [DefaultSyncScrollController].
class SyncScrollController {
  List<ScrollController> _registeredScrollControllers = <ScrollController>[];

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  SyncScrollController([List<ScrollController> controllers]) {
    if (controllers != null) {
      controllers.forEach((controller) => registerScrollController(controller));
    }
  }

  /// The current scroll offset of the scrollable widgets.
  double get scrollOffset {
    if (_registeredScrollControllers.isEmpty) return 0.0;

    final ScrollController controller = _registeredScrollControllers.firstWhere((c) => c.hasClients);
    if (controller == null) return 0.0;

    return controller.offset ?? 0.0;
  }

  /// Add a scroll controller for synchronous control.
  void add(ScrollController controller) {
    registerScrollController(controller);
  }

  /// Remove the scroll controller from synchronous control.
  void remove(ScrollController controller) {
    _registeredScrollControllers.remove(controller);
  }

  @protected
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
