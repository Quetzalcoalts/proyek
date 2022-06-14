import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/storage_files.dart';

class ProfileWidget extends StatelessWidget {
  final String user_email;
  final Storage storage = Storage();
  final AsyncSnapshot<String> snapshot;
  final VoidCallback onClicked;
  ProfileWidget(
      {Key? key,
      required this.snapshot,
      required this.onClicked,
      required this.user_email})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(bottom: 0, right: 4, child: buildEditIcon(color)),
        ],
      ),
    );
  }

  Widget buildImage() {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      final image = NetworkImage(snapshot.data!);
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
            child: InkWell(
              onTap: onClicked,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 0,
        child: Builder(builder: (context) {
          return SizedBox(
            height: 50,
            width: 50,
            child: ElevatedButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png']);
                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No File Selected")));
                  return null;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("File Selected")));
                }
                final path = result.files.single.path!;
                final filename = user_email;
                //final fileName = result.files.single.name;
                print(path);
                // print(fileName);
                storage.UploadFile(filename, path)
                    .then((value) => print('Done'));
              },
              child: buildCircle(
                  color: color,
                  all: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.upload,
                      color: Colors.white,
                      size: 20,
                    ),
                  )),
            ),
          );
        }),
      );
  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          child: child,
          color: color,
          padding: EdgeInsets.all(all),
        ),
      );
}
