import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite_app/features/bpm/db/bp_database.dart';
import 'package:sqflite_app/features/bpm/model/bp_model.dart';
import '../../../product/mixin/navigator_mixin.dart';
import '../../../product/navigator/navigator_custom.dart';
import '../../../product/widget/bp_card_widget.dart';

class BPHomePage extends StatefulWidget {
  const BPHomePage({super.key});

  @override
  _BPHomePageState createState() => _BPHomePageState();
}

class _BPHomePageState extends State<BPHomePage> with NavigatorMixin {
  late List<BPModel> models;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshBP();
  }

  @override
  void dispose() {
    BPDatabase.instance.close();
    super.dispose();
  }

  Future refreshBP() async {
    setState(() => isLoading = true);
    models = await BPDatabase.instance.readAll();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'BPM',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : models.isEmpty
                  ? const Text(
                      'No BP',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await router.pushToPage(NavigateCustomEnum.addEditBP);

            refreshBP();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: models.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final model = models[index];

          return GestureDetector(
            onTap: () async {
              await router.pushToPage(
                NavigateCustomEnum.detailBP,
                arguments: model,
              );

              refreshBP();
            },
            child: BPCardWidget(model: model, index: index),
          );
        },
      );
}
