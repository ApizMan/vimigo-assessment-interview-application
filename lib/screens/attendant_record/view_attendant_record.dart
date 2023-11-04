import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimigo_technical_interview/public_components/loading_dialog.dart';
import 'package:vimigo_technical_interview/resources/attendant_resources.dart';

// ignore: must_be_immutable
class ViewAttendantRecord extends StatefulWidget {
  int attendantId;
  ViewAttendantRecord({
    super.key,
    required this.attendantId,
  });

  @override
  State<ViewAttendantRecord> createState() => _ViewAttendantRecordState();
}

class _ViewAttendantRecordState extends State<ViewAttendantRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: const CloseButton(
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: AttendantResources()
            .getSingleAttendant(widget.attendantId.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final checkIn = DateTime.parse(snapshot.data['data']['checkIn']);
            final date = '$checkIn';
            DateTime parseDate =
                DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(date);
            var inputDate = DateTime.parse(parseDate.toString());
            var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
            var outputDate = outputFormat.format(inputDate);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    "View Attendant",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        snapshot.data['data']['user'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Phone Number: ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        snapshot.data['data']['phone'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Check-In: ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        outputDate,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final name = snapshot.data['data']['user'];
                            final phoneNum = snapshot.data['data']['phone'];
                            await Share.share("Name: $name\nPhone Number: $phoneNum\nCheck-In: $outputDate");
                          },
                          icon: const Icon(Icons.share),
                          label: const Text("Share"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const LoadingDialog();
          }
        },
      ),
    );
  }
}
