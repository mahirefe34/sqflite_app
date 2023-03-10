import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_app/features/bpm/db/bp_database.dart';
import 'package:sqflite_app/features/bpm/model/bp_model.dart';
import 'package:sqflite_app/product/navigator/navigator_custom.dart';
import '../../../product/mixin/navigator_mixin.dart';

class BPDetailPage extends StatefulWidget {
  final int modelId;

  const BPDetailPage({
    Key? key,
    required this.modelId,
  }) : super(key: key);

  @override
  _BPDetailPageState createState() => _BPDetailPageState();
}

class _BPDetailPageState extends State<BPDetailPage> with NavigatorMixin {
  late BPModel model;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    model = await BPDatabase.instance.readSingle(widget.modelId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      model.systolic,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(model.createdTime),
                      style: const TextStyle(color: Colors.white38),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.description,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await router.pushToPage(NavigateCustomEnum.addEditBP, arguments: model);

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await BPDatabase.instance.delete(widget.modelId);

          router.popToPage();
        },
      );
}
