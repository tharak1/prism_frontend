import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:frontend/models/prevQP_model.dart';
import 'package:open_file/open_file.dart';

class PrevQpItem extends StatefulWidget {
  const PrevQpItem({Key? key, required this.prevQp}) : super(key: key);

  final PrevQp prevQp;

  @override
  _PrevQpItemState createState() => _PrevQpItemState();
}

class _PrevQpItemState extends State<PrevQpItem> {
  bool downloadStarted = false;
  bool downloadCompleted = false;
  double progress = 0.00;
  String? pdfPath;
  bool isAlreadyDownloaded = false;
  String alreadyDownloadedPath = '';

  @override
  void initState() {
    super.initState();
    getDownloadedPapers();
  }

  Future<void> openPdf() async {
    try {
      if (pdfPath != null) {
        await OpenFile.open(pdfPath!);
      }
    } catch (error) {
      print('Error opening PDF: $error');
    }
  }

  Future<void> getDownloadedPapers() async {
    List<PrevQp> existingPrevQpList =
        await PrevQp.loadListFromLocalStorage('downloadedPapers');
    // print(existingPrevQpList);

    setState(() {
      isAlreadyDownloaded =
          existingPrevQpList.any((qp) => qp.Id == widget.prevQp.Id);

      if (isAlreadyDownloaded) {
        PrevQp alreadyDownloadedBook = existingPrevQpList
            .firstWhere((book) => book.Id == widget.prevQp.Id);
        alreadyDownloadedPath = alreadyDownloadedBook.PrevQuestionPaperUrl;
        pdfPath = alreadyDownloadedPath;
      }
    });
  }

  // Future<void> downloadPdf() async {
  //   print(
  //       "Hoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
  //   PermissionStatus status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     Directory? dir = await getExternalStorageDirectory();
  //     if (dir != null) {
  //       String saveName = "${widget.prevQp.SubjectName}.pdf";
  //       String savePath = '${dir.path}/$saveName';
  //       setState(() {
  //         pdfPath = savePath;
  //       });

  //       try {
  //         setState(() {
  //           downloadStarted = true;
  //         });

  //         await Dio().download(
  //           widget.prevQp.PrevQuestionPaperUrl,
  //           savePath,
  //           onReceiveProgress: (received, total) {
  //             if (total != -1) {
  //               setState(() {
  //                 progress = received / total;
  //               });
  //             }
  //           },
  //         );

  //         setState(() {
  //           downloadStarted = false;
  //           downloadCompleted = true;
  //         });

  //         if (pdfPath != null) {
  //           List<PrevQp> existingPaperList =
  //               await PrevQp.loadListFromLocalStorage('downloadedPapers');

  //           PrevQp newPaper = PrevQp(
  //             Id: widget.prevQp.Id,
  //             Department: widget.prevQp.Department,
  //             Regulation: widget.prevQp.Regulation,
  //             SubjectName: widget.prevQp.SubjectName,
  //             PrevQuestionPaperAddress: widget.prevQp.PrevQuestionPaperAddress,
  //             PrevQuestionPaperUrl: pdfPath!,
  //           );

  //           existingPaperList.add(newPaper);

  //           await PrevQp.saveListToLocalStorage(
  //               existingPaperList, 'downloadedPapers');
  //         }

  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text("File Downloaded"),
  //         ));
  //       } on DioException catch (e) {
  //         print('Dio Error: $e');
  //       }
  //     }
  //   }
  // }

  Future<void> downloadPdf() async {
    print("Starting PDF download process...");

    // Request storage permission
    PermissionStatus status = await Permission.mediaLibrary.request();

    if (status.isDenied) {
      // If permission is denied, show a dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Storage permission is required to download files. Please allow it in the app settings."),
      ));
      await Permission.storage.request();
      // await Permission.manageExternalStorage.request();
      return;
    } else if (status.isPermanentlyDenied) {
      // If permanently denied, open the app settings
      await openAppSettings();
      await Permission.storage.request();
      return;
    } else if (status.isGranted) {
      Directory? dir = await getExternalStorageDirectory();
      if (dir == null) {
        print("Error: Could not access external storage directory.");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Unable to access storage. Please try again."),
        ));
        return;
      }

      String saveName = "${widget.prevQp.SubjectName}.pdf";
      String savePath = '${dir.path}/$saveName';

      debugPrint(dir.path);

      setState(() {
        pdfPath = savePath;
        downloadStarted = true;
      });

      try {
        await Dio().download(
          widget.prevQp.PrevQuestionPaperUrl,
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() {
                progress = received / total;
              });
            }
          },
        );

        setState(() {
          downloadStarted = false;
          downloadCompleted = true;
        });

        // Save the downloaded PDF information locally
        if (pdfPath != null) {
          List<PrevQp> existingPaperList =
              await PrevQp.loadListFromLocalStorage('downloadedPapers');

          PrevQp newPaper = PrevQp(
            Id: widget.prevQp.Id,
            Department: widget.prevQp.Department,
            Regulation: widget.prevQp.Regulation,
            SubjectName: widget.prevQp.SubjectName,
            PrevQuestionPaperAddress: widget.prevQp.PrevQuestionPaperAddress,
            PrevQuestionPaperUrl: pdfPath!,
          );

          existingPaperList.add(newPaper);
          await PrevQp.saveListToLocalStorage(
              existingPaperList, 'downloadedPapers');
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("File Downloaded Successfully"),
        ));
      } catch (e) {
        print('Error during download: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to download the file."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.prevQp.SubjectName),
      subtitle: Text(widget.prevQp.Department),
      leading: Text(widget.prevQp.Regulation),
      trailing: isAlreadyDownloaded || downloadCompleted
          ? ElevatedButton.icon(
              onPressed: () {
                openPdf();
              },
              icon: Icon(Icons.check),
              label: Text("Tap to open"))
          : downloadStarted
              ? Center(
                  child: CircularProgressIndicator.adaptive(
                  value: progress,
                ))
              : ElevatedButton.icon(
                  onPressed: () {
                    // openPdf();
                    downloadPdf();
                  },
                  icon: Icon(Icons.download),
                  label: Text("Downlad")),
    );
  }
}







// Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       width: MediaQuery.of(context).size.width,
//       height: 130,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 3,
//             blurRadius: 10,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Row(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width - 50,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     widget.prevQp.SubjectName,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   Text(
//                     "${widget.prevQp.Department} - ${widget.prevQp.Regulation}",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       isAlreadyDownloaded || downloadCompleted
//                           ? ElevatedButton.icon(
//                               onPressed: () {
//                                 openPdf();
//                               },
//                               icon: Icon(Icons.check),
//                               label: Text("Tap to open"))
//                           : downloadStarted
//                               ? Center(
//                                   child: CircularProgressIndicator.adaptive(
//                                   value: progress,
//                                 ))
//                               : ElevatedButton.icon(
//                                   onPressed: () {
//                                     // openPdf();
//                                     downloadPdf();
//                                   },
//                                   icon: Icon(Icons.download),
//                                   label: Text("Downlad"))
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     )