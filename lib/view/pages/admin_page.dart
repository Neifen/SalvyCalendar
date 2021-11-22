import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:salvy_calendar/data/repo/corp_repo.dart';
import 'package:salvy_calendar/data/repo/day_repo.dart';
import 'package:salvy_calendar/models/content_type.dart';
import 'package:salvy_calendar/models/item_model.dart';
import 'package:salvy_calendar/models/media_file_model.dart';
import 'package:salvy_calendar/services/days_service.dart';
import 'package:salvy_calendar/util/day_util.dart';
import 'package:salvy_calendar/util/style.dart';
import 'package:salvy_calendar/view/widgets/footer.dart';
import 'package:salvy_calendar/view/widgets/thumbnail.dart';

//todo: circular loading thing
class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var addNewCorp = false;
  String? corp;
  Map<int, MediaFileModel>? days;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: GlobalKey(debugLabel: 'AdminPage'),
        backgroundColor: Style.backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Visibility(
                  visible: addNewCorp,
                  child: Row(
                    children: [
                      Flexible(child: TextField(onChanged: (s) => corp = s.trim(), decoration: const InputDecoration(label: Text('Neuen Korp eingeben')))),
                      Spacer(),
                      IconButton(
                        onPressed: _addNewCorp,
                        icon: Icon(Icons.check),
                      ),
                      IconButton(
                        onPressed: _cancelAddNewCorp,
                        icon: Icon(Icons.cancel),
                      )
                    ],
                  )),
              Visibility(
                visible: !addNewCorp,
                child: Center(
                  child: FutureBuilder<List<String>>(
                      future: CorpRepo().getAll(),
                      initialData: [],
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return DropdownButton(
                            hint: Text('Korps auswählen'),
                            value: corp,
                            onChanged: _selectDropCorp,
                            items: [
                              DropdownMenuItem(value: true, child: Text('Korps hinzufügen')),
                              ...snapshot.data!
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList()
                            ],
                          );
                        }
                        return CircularProgressIndicator();
                      }),
                ),
              ),
              Visibility(
                visible: days != null,
                child: Flexible(
                    child: ListView.builder(
                        itemCount: 24,
                        itemBuilder: (_, dayMinusOne) {
                          int day = dayMinusOne + 1;
                          MediaFileModel? mediaFile = days![day];
                          var textEditingController = TextEditingController(text: mediaFile?.description);
                          return Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: Text('$day', style: TextStyle(fontSize: 40))),
                                    Flexible(
                                      flex: 10,
                                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: TextField(
                                                controller: textEditingController,
                                                decoration: const InputDecoration(label: Text('Beschreibung')),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  DaysService.editDescription(corp!, day, mediaFile, textEditingController.text);
                                                },
                                                icon: Icon(Icons.check)),
                                            IconButton(
                                                onPressed: () {
                                                  textEditingController.text = mediaFile != null ? mediaFile.description : '';
                                                },
                                                icon: Icon(Icons.cancel))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 80,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: mediaFile == null ? 1 : mediaFile.items.length + 1,
                                              itemBuilder: (_, indexPlusOne) {
                                                if (indexPlusOne == 0) {
                                                  return Card(
                                                    child: TextButton(
                                                      onPressed: () async {
                                                        var pickFiles = await FilePicker.platform.pickFiles(
                                                            type: FileType.custom,
                                                            allowedExtensions: ['jpg', 'jpeg', 'gif', 'png', 'mov', 'mp4'],
                                                            dialogTitle: 'Wähle Dateien aus');
                                                        if (pickFiles != null) {
                                                          for (var file in pickFiles.files) {
                                                            await DaysService.addItemToDay(corp!, mediaFile!, file);
                                                            setState(() {});
                                                          }
                                                        }
                                                      },
                                                      child: Icon(Icons.add_a_photo),
                                                    ),
                                                  );
                                                }
                                                var index = indexPlusOne - 1;
                                                var item = days![day]!.items[index];
                                                return Card(
                                                    child: Stack(
                                                  children: [
                                                    _getThumbnail(corp!, days![day]!, item),
                                                    Align(
                                                        alignment: Alignment.topRight,
                                                        child: IconButton(
                                                            onPressed: () async {
                                                              await DaysService.deleteItemFromDay(corp!, mediaFile!, item);
                                                              setState(() {});
                                                            },
                                                            icon: Icon(Icons.delete)))
                                                  ],
                                                ));
                                              }),
                                        )
                                      ]),
                                    )
                                  ],
                                )),
                          );
                        })),
              )
            ],
          ),
        ),
        bottomSheet: Footer());
  }

  _setNewCorp(bool value) {
    setState(() {
      addNewCorp = value;
    });
  }

  _cancelAddNewCorp() {
    corp = null;
    _setNewCorp(false);
  }

  _addNewCorp() {
    _setNewCorp(false);

    if (corp != null) {
      CorpRepo().save(corp!);
    }
  }

  _selectDropCorp(Object? selection) async {
    if (selection is bool) {
      corp = null;
      _setNewCorp(true);
    } else {
      corp = selection as String;
      days = await DayRepo().getAll(corp!);

      setState(() {});
    }
  }

  Widget _getThumbnail(String corp, MediaFileModel model, ItemModel item) {
    switch (item.contentType) {
      case ContentType.video:
        return Thumbnail(corp, model, item);
      case ContentType.image:
        return Image.network(item.path);
      default:
        return const Icon(Icons.image_not_supported);
    }
  }
}
