import 'dart:math';

import 'package:flutter/material.dart';

class MaterialyouSearchbarDemo extends StatelessWidget {
  const MaterialyouSearchbarDemo({super.key});

  static const routeName = '/materialyou_searchbar_demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MaterialYouSearchBar(),
        body: ListView.builder(itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        }));
  }
}

class MaterialYouSearchBar extends StatefulWidget
    implements PreferredSizeWidget {
  const MaterialYouSearchBar(
      {super.key,
      this.bottom,
      this.backgroundColor,
      this.toolbarHeight,
      this.leading,
      this.title,
      this.trailing,
      this.primary});
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final bool? primary;

  @override
  State<MaterialYouSearchBar> createState() => _MaterialYouSearchBarState();

  @override
  Size get preferredSize =>
      _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);
}

class _MaterialYouSearchBarState extends State<MaterialYouSearchBar> {
  final uniqueHeroTag = UniqueKey().toString();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: widget.primary ?? true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Hero(
          createRectTween: (begin, end) {
            return MaterialRectCenterArcTween(begin: begin, end: end);
          },
          flightShuttleBuilder: (flightContext, animation, direction,
                  fromContext, toContext) =>
              AnimatedBuilder(
                  animation: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOutCubicEmphasized),
                  builder: (context, _) {
                    return Material(
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.backgroundColor ??
                              Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius:
                              BorderRadius.circular(32 * (1 - animation.value)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: (MediaQuery.of(context).padding.top) *
                                      animation.value),
                              alignment: Alignment.topCenter,
                              child: Ink(
                                height: widget.toolbarHeight ?? 56,
                                width: double.infinity, // match parent
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 16),
                                      Stack(
                                        children: [
                                          Opacity(
                                            opacity: 1 - animation.value,
                                            child: Transform.rotate(
                                                angle:
                                                    -0.5 * pi * animation.value,
                                                child: widget.leading ??
                                                    const Icon(Icons.search)),
                                          ),
                                          Opacity(
                                            opacity: animation.value,
                                            child: Transform.rotate(
                                                angle: 0.5 *
                                                    pi *
                                                    (1 - animation.value),
                                                child: widget.leading ??
                                                    const Icon(
                                                        Icons.arrow_back)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      widget.title ??
                                          Expanded(
                                              child: IgnorePointer(
                                            child: TextFormField(
                                              controller: searchController,
                                              decoration: InputDecoration(
                                                hintText: 'Hinted Search Text',
                                                hintStyle: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )),
                                      const SizedBox(width: 16),
                                      Opacity(
                                        opacity: animation.value,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            //delete text
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                      widget.trailing ??
                                          PopupMenuButton(
                                              itemBuilder: (context) {
                                            return [
                                              const PopupMenuItem(
                                                child: Text('Settings'),
                                              ),
                                            ];
                                          }),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                                child: Opacity(
                                    opacity: animation.value,
                                    child: const Divider()))
                          ],
                        ),
                      ),
                    );
                  }),
          tag: uniqueHeroTag,
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) {
                        return ExpandedSearchBarWidget(
                          tag: uniqueHeroTag,
                          searchController: searchController,
                        );
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ));
              },
              borderRadius: BorderRadius.circular(32),
              child: _buildContentRow(),
            ),
          ),
        ),
      ),
    );
  }

  Ink _buildContentRow() {
    return Ink(
      height: widget.toolbarHeight ?? 56,
      width: double.infinity, // match parent
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(32),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            widget.leading ??
                Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            const SizedBox(width: 16),
            widget.title ??
                Expanded(
                    child: IgnorePointer(
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Hinted Search Text',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            const SizedBox(width: 16),
            widget.trailing ??
                PopupMenuButton(itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      child: Text('Settings'),
                    ),
                  ];
                }),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class ExpandedSearchBarWidget extends StatefulWidget {
  const ExpandedSearchBarWidget({
    super.key,
    required this.tag,
    required this.searchController,
  });

  final String tag;
  final TextEditingController searchController;

  @override
  State<ExpandedSearchBarWidget> createState() =>
      _ExpandedSearchBarWidgetState();
}

class _ExpandedSearchBarWidgetState extends State<ExpandedSearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      createRectTween: (begin, end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      tag: widget.tag,
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: SafeArea(
              child: Column(
                children: [
                  Ink(
                    height: 56,
                    width: double.infinity, // match parent
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                              child: TextFormField(
                            autofocus: true,
                            controller: widget.searchController,
                            decoration: InputDecoration(
                              hintText: 'Hinted Search Text',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              border: InputBorder.none,
                            ),
                          )),
                          const SizedBox(width: 16),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              //delete text
                              widget.searchController!.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                child: Text('Settings'),
                              ),
                            ];
                          }),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight((toolbarHeight ?? 56 + 32) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
