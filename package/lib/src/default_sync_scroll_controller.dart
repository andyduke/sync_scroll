import 'package:flutter/widgets.dart';
import 'sync_scroll_controller.dart';
import 'sync_scroll_controller_scope.dart';

/// The [SyncScrollController] for descendant widgets that don't specify one
/// explicitly.
///
/// [DefaultSyncScrollController] is an inherited widget that is used to share a
/// [SyncScrollController] with a [ClientScrollController].
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
