import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_cassette_cover_generator/utils/constants.dart';
import 'package:game_cassette_cover_generator/utils/helper.dart';
import 'package:universal_io/io.dart' as io;
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CoverEditorPage extends StatefulWidget {
  const CoverEditorPage({super.key});

  @override
  State<CoverEditorPage> createState() => _CoverEditorPageState();
}

class _CoverEditorPageState extends State<CoverEditorPage> {
  final WidgetsToImageController _widgetsToImageController =
      WidgetsToImageController();

  String _platform = 'GB';
  String? _template;

  Color _spineTopColor = Colors.white;
  Color _spinePrimaryColor = Colors.white;
  Color _spineBottomColor = Colors.white;
  Color _frontTopColor = Colors.white;
  Color _frontBottomColor = Colors.white;
  Color _backPrimaryColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(children: [
        editorToolTab(),
        artworkCanvas(),
      ]),
    );
  }

  editorToolTab() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(12),
      height: double.infinity,
      color: Colors.grey.shade300,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                DropdownButtonFormField(
                    decoration: const InputDecoration(label: Text('Platform')),
                    hint: const Text("Select game platform"),
                    value: _platform,
                    items: Helper.getDropdownMenuItem(Constants.platforms),
                    onChanged: (val) {
                      if (val != null) setState(() => _platform = val);
                    }),
                DropdownButtonFormField(
                    decoration:
                        const InputDecoration(label: Text('Cover Templates')),
                    hint: const Text("Select cover templates"),
                    value: _template,
                    items: Helper.getDropdownMenuItem(
                      Constants.coverTemplates,
                      filter: (obj) => obj['platform'] == _platform,
                    ),
                    onChanged: (val) {
                      if (val != null) setState(() => _template = val);
                    })
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => showSaveImageOption(),
              child: const Text('Save'),
            ),
          )
        ],
      ),
    );
  }

  artworkCanvas() {
    var templateSize = Helper.templateSize;

    return WidgetsToImage(
      controller: _widgetsToImageController,
      child: Center(
        child: SizedBox(
          width: 1.sw - 300,
          height: 1.sh,
          child: Stack(
            children: [
              SizedBox(
                width: templateSize.width,
                height: templateSize.height,
                child: Row(children: [
                  Container(
                      height: double.infinity,
                      width: templateSize.width * .25,
                      color: _backPrimaryColor),
                  Container(
                    width: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.blue,
                    height: double.infinity,
                    width: templateSize.width * .12,
                    child: Column(
                      children: [
                        Container(
                          height: 195,
                          width: double.infinity,
                          
                        ),
                        Expanded(
                          child: Container(
                            color: _spinePrimaryColor,
                          ),
                        ),
                        Container(
                          height: 70,
                          color: _spineBottomColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Container(
                    width: 1,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          color: _frontTopColor,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: InteractiveViewer(
                                child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/en/1/1d/KingdomHeartsCoMCover_.jpg',
                            )),
                          ),
                        ),
                        Container(
                          height: 70,
                          color: _frontBottomColor,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              if (_template != null)
                Opacity(
                  opacity: .2,
                  child: Image.asset(
                    _template!,
                    width: templateSize.width,
                    height: templateSize.height,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  showSaveImageOption() async {
    try {
      var bytes = await _widgetsToImageController.capture();

      if (bytes != null) {
        var content = base64Encode(bytes);
        final anchor = AnchorElement(href: "data:image/jpeg;base64,$content")
          ..setAttribute("download", "cover.jpeg")
          ..click();
      }
    } catch (err) {
      print(err);
    }
  }
}
