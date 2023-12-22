import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter_color_models/flutter_color_models.dart';

class TreeviewTest extends StatefulWidget {
  const TreeviewTest({super.key, required this.title});

  final String title;

  @override
  State<TreeviewTest> createState() => _TreeviewTeState();
}

class _TreeviewTeState extends State<TreeviewTest> {
  TreeViewController? _controller;
  final expandChildrenOnReady = false;
  final showSnackBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 36),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: sampleTree.expansionNotifier,
        builder: (context, isExpanded, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (sampleTree.isExpanded) {
                _controller?.collapseNode(sampleTree);
              } else {
                _controller?.expandAllChildren(sampleTree);
              }
            },
            label: isExpanded
                ? const Text("Collapse all")
                : const Text("Expand all"),
          );
        },
      ),
      body: TreeView.simple(
        tree: sampleTree,
        showRootNode: true,
        expansionBehavior: ExpansionBehavior.collapseOthersAndSnapToTop,
        expansionIndicatorBuilder: (context, node) =>
            // PlusMinusIndicator(
            //   tree: node,
            //   color: Colors.blue[700],
            //   padding: const EdgeInsets.all(16),
            // )
            PlusMinusIndicator(
          alignment: Alignment.centerLeft,
          tree: node,
          color: Colors.blue[700],
          padding: const EdgeInsets.all(8),
        ),
        indentation: const Indentation(
          style: IndentStyle.squareJoint,
          // color: Colors.red,
          // thickness: 4,
        ),
        onItemTap: (item) {
          if (kDebugMode) print('Item tapped: ${item.key}');
          if (showSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Item tapped: ${item.key}'),
              duration: const Duration(milliseconds: 750),
            ));
          }
        },
        onTreeReady: (controller) {
          _controller = controller;
          if (expandChildrenOnReady) controller.expandAllChildren(sampleTree);
        },
        builder: (context, node) => Card(
          // color: Colors.blue,
          margin:
              const EdgeInsets.only(left: 40, top: 10, bottom: 10, right: 10),
          color: colorMapper(Colors.blue, max(node.level, 10),
              node.level.clamp(0, node.level).toInt()),

          child: ListTile(
            title: Text('Item ${node.level}-${node.key}'),
            subtitle: Text('Level ${node.level}'),
            leading: SizedBox(width: 40, child: folderIcon(node)),
            trailing: SizedBox(
              width: 55 * 2,
              child: Row(children: [
                IconButton(
                    onPressed: () {
                      node.add(TreeNode(
                          key:
                              '${node.key}${node.level + 1}${alphabet(node.length)}'));
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {
                      recursiveDeleteTreeNode(node);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

Color colorMapper(MaterialColor baseColor, int length, int index) {
  final darkestColor = baseColor[400]!;
  final lightestColor = baseColor[50]!;

  final palletPicker = <ColorModel>[
    RgbColor.fromColor(Color.fromARGB(lightestColor.alpha, lightestColor.red,
        lightestColor.green, lightestColor.blue)),
    RgbColor.fromColor(Color.fromARGB(darkestColor.alpha, darkestColor.red,
        darkestColor.green, darkestColor.blue))
  ];
  final pallet = palletPicker.augment(length);
  return const RgbColor(0, 0, 0).withChroma(pallet[index].chroma).toColor();
}

String alphabet(index) {
  return List.generate(26, (index) => String.fromCharCode(index + 65))[index];
}

void recursiveDeleteTreeNode(Node node) {
  if (!node.isLeaf) {
    node.removeAll(node.children.values);
  }
  node.delete();
}

Widget folderIcon(TreeNode node) {
  if (node.isLeaf) {
    return const Icon(Icons.insert_drive_file);
  } else if (node.length >= 1) {
    if (node.isExpanded) {
      return const Icon(Icons.folder_copy_rounded);
    }
    return const Icon(Icons.folder_copy);
  }
  if (node.isExpanded) {
    return const Icon(Icons.folder_open);
  } else {
    return const Icon(Icons.folder);
  }
}

final sampleTree = TreeNode.root()
  ..addAll([
    TreeNode(key: "0A")..add(TreeNode(key: "0A1A")),
    TreeNode(key: "0C")
      ..addAll([
        TreeNode(key: "0C1A"),
        TreeNode(key: "0C1B"),
        TreeNode(key: "0C1C")
          ..addAll([
            TreeNode(key: "0C1C2A")
              ..addAll([
                TreeNode(key: "0C1C2A3A"),
                TreeNode(key: "0C1C2A3B"),
                TreeNode(key: "0C1C2A3C"),
              ]),
          ]),
      ]),
    TreeNode(key: "0D"),
    TreeNode(key: "0E"),
  ]);
