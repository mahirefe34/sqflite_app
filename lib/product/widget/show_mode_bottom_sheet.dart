/* floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet<dynamic>(
            isScrollControlled: true,
            useSafeArea: false,
            isDismissible: false,
            enableDrag: false,
            context: context,
            builder: (BuildContext builderContext) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Form(
                  child: Column(
                    children: [
                      Text(
                        titleText,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      TextFormField(
                        controller: titleController,
                        maxLength: 30,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: titleText,
                        ),
                      ),
                      Text(
                        noteText,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      TextFormField(
                        controller: noteController,
                        maxLines: 3,
                        maxLength: 100,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: noteText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(builderContext, 1);
                              },
                              child: Text(cancelText),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final model = NoteModel(
                                  title: titleController.text,
                                  note: noteController.text,
                                  date: DateTime.now(),
                                  isComplate: false,
                                );
                                Navigator.pop(builderContext, model);
                              },
                              child: Text(saveText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          if (result is NoteModel) {
            final model = Hive.box<NoteModel>('notes')
                .put(result.date?.toIso8601String(), result);
            print(model);
          } else {
            print('here');
          }
        },
        tooltip: 'New Note',
        child: const Icon(Icons.add),
      ), */