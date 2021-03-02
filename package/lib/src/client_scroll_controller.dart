import 'package:flutter/widgets.dart';
import 'sync_scroll_controller_scope.dart';

class ClientScrollController extends StatefulWidget {
  final Widget Function(BuildContext context, ScrollController controller) builder;

  const ClientScrollController({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  _ClientScrollControllerState createState() => _ClientScrollControllerState();
}

class _ClientScrollControllerState extends State<ClientScrollController> {
  ScrollController controller;
  Widget child;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (controller == null) {
      final double currentScrollOffset = SyncScrollControllerScope.of(context).scrollOffset;
      controller = ScrollController(
        initialScrollOffset: currentScrollOffset,
      );
    }

    if (child == null) {
      child = widget.builder(context, controller);
    }

    SyncScrollControllerScope.of(context).remove(controller);
    SyncScrollControllerScope.of(context).add(controller);
  }

  @override
  void didUpdateWidget(covariant ClientScrollController oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.builder != widget.builder) {
      child = widget.builder(context, controller);
    }
  }

  @override
  void deactivate() {
    SyncScrollControllerScope.of(context).remove(controller);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        SyncScrollControllerScope.of(context).processNotification(scrollInfo, controller);
        return false;
      },
      child: child,
    );
  }
}
