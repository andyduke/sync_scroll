# SyncScroll

Synchronous scrolling of multiple scrollable widgets.

## Getting Started

`SyncScroll` allows you to make synchronous scrolling of two or more scrollable widgets, for example, two horizontal `ListView`.

For example:

![](../screenshots/demo.gif)

```dart
DefaultSyncScrollController(
  Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // First ListView
      Container(
        width: double.infinity,
        height: 60,
        child: ClientScrollController(
          builder: (context, controller) => ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) => Container(
              width: 80,
              height: 60,
              child: Text('Cell $index'),
            ),
          ),
        ),
      ),

      const Divider(),

      // Second ListView
      Container(
        width: double.infinity,
        height: 60,
        child: ClientScrollController(
          builder: (context, controller) => ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) => Container(
              width: 80,
              height: 60,
              child: Text('Cell $index'),
            ),
          ),
        ),
      ),

    ],
  ),
);
```