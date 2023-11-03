import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vimigo_technical_interview/model/attendant_model.dart';
import 'package:vimigo_technical_interview/resources/attendant_resources.dart';
import 'package:vimigo_technical_interview/screens/attendant_record/components/attendant_record_body.dart';
import 'package:vimigo_technical_interview/screens/attendant_record/create_attendant_record.dart';

class AttendantRecord extends StatefulWidget {
  const AttendantRecord({super.key});

  @override
  State<AttendantRecord> createState() => _AttendantRecordState();
}

bool isDescending = false;
bool isChangeFormat = false;

class _AttendantRecordState extends State<AttendantRecord> {
  _saveBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("descendingOrder", isDescending);
    await prefs.setBool("changeFormat", isChangeFormat);
    print(await prefs.setBool("descendingOrder", isDescending));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AttendantResources().getListAttendants(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AttendantModel> items = List.generate(
              snapshot.data['data'].length,
              (index) => AttendantModel(
                user: snapshot.data['data'][index]['user'],
                phone: snapshot.data['data'][index]['phone'],
                checkIn: snapshot.data['data'][index]['checkIn'],
              ),
            );

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                centerTitle: true,
                title:
                    Text(isDescending ? "Descending Order" : "Ascending Order"),
                leading: IconButton(
                  icon: const Icon(
                    Icons.format_color_text_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isChangeFormat = !isChangeFormat;
                      _saveBool();
                    });
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isDescending ? Icons.sort : Icons.sort_by_alpha_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isDescending = !isDescending;
                        _saveBool();
                      });
                    },
                  ),
                ],
              ),
              body: AttendantRecordBody(
                snapshot: snapshot,
                items: items,
                isDescending: isDescending,
                isChangeFormat: isChangeFormat,
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CreateAttendantRecord(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return const Scaffold();
          }
        });
  }
}
