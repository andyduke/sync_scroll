import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'sync_scroll_controller.dart';

class SyncScrollControllerScope extends InheritedWidget {
  final SyncScrollController controller;
  final Widget child;

  SyncScrollControllerScope({
    Key key,
    @required this.controller,
    @required this.child,
  }) : super(key: key, child: child);

  static SyncScrollController of(BuildContext context) {
    final SyncScrollControllerScope result = context.dependOnInheritedWidgetOfExactType<SyncScrollControllerScope>();
    return result?.controller;
  }

  @override
  bool updateShouldNotify(SyncScrollControllerScope oldWidget) => controller != oldWidget.controller;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<SyncScrollController>('controller', controller, ifNull: 'no controller', showName: false));
  }
}
