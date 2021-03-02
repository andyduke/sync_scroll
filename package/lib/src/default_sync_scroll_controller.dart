import 'package:flutter/widgets.dart';
import 'sync_scroll_controller.dart';
import 'sync_scroll_controller_scope.dart';

class DefaultSyncScrollController extends StatefulWidget {
  final Widget child;

  const DefaultSyncScrollController({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _DefaultSyncScrollControllerState createState() => _DefaultSyncScrollControllerState();
}

class _DefaultSyncScrollControllerState extends State<DefaultSyncScrollController> {
  final SyncScrollController _controller = SyncScrollController();

  @override
  Widget build(BuildContext context) {
    return SyncScrollControllerScope(
      child: widget.child,
      controller: _controller,
    );
  }
}
