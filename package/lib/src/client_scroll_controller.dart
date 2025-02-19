import 'package:flutter/widgets.dart';
import 'sync_scroll_controller_scope.dart';

typedef ClientScrollControllerBuilder = Widget Function(
    BuildContext context, ScrollController controller);

/// Provides a scroll controller and synchronizes its scrolling
/// with the [SyncScrollController].
///
/// ```
/// DefaultSyncScrollController(
///   child: Column(
///     crossAxisAlignment: CrossAxisAlignment.stretch,
///     children: [
///       ClientScrollController(
///         builder: (context, controller) => ListView.builder(
///           controller: controller,
///           scrollDirection: Axis.horizontal,
///           itemCount: 20,
///           itemBuilder: (context, index) => Container(width: 80, height: 60, alignment: Alignment.center, child: Text('Cell $index')),
///         ),
///       ),
///       const Divider(),
///       ClientScrollController(
///         builder: (context, controller) => ListView.builder(
///           controller: controller,
///           scrollDirection: Axis.horizontal,
///           itemCount: 20,
///           itemBuilder: (context, index) => Container(width: 80, height: 60, alignment: Alignment.center, child: Text('Cell $index')),
///         ),
///       ),
///     ],
///   ),
/// )
/// ```
class ClientScrollController extends StatefulWidget {
  /// Called to obtain the child widget and provide a scroll controller to it.
  final ClientScrollControllerBuilder builder;

  const ClientScrollController({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  _ClientScrollControllerState createState() => _ClientScrollControllerState();
}

class _ClientScrollControllerState extends State<ClientScrollController> {
  ScrollController? controller;
  Widget? child;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (controller == null) {
      final double currentScrollOffset =
          SyncScrollControllerScope.of(context)?.scrollOffset ?? 0;
      controller = ScrollController(
        initialScrollOffset: currentScrollOffset,
      );
    }

    if (child == null) {
      child = widget.builder(context, controller!);
    }

    SyncScrollControllerScope.of(context)?.remove(controller!);
    SyncScrollControllerScope.of(context)?.add(controller!);
  }

  @override
  void didUpdateWidget(covariant ClientScrollController oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.builder != widget.builder) {
      child = widget.builder(context, controller!);
    }
  }

  @override
  void deactivate() {
    if (controller != null) {
      SyncScrollControllerScope.of(context)?.remove(controller!);
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        SyncScrollControllerScope.of(context)
            ?.processNotification(scrollInfo, controller!);
        return false;
      },
      child: child!,
    );
  }
}
