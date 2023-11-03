import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:vimigo_technical_interview/model/attendant_model.dart';
import 'package:vimigo_technical_interview/screens/attendant_record/view_attendant_record.dart';
import 'package:vimigo_technical_interview/widget/blank_content.dart';

// ignore: must_be_immutable
class AttendantRecordBody extends StatefulWidget {
  AsyncSnapshot<dynamic> snapshot;
  List<AttendantModel> items;
  bool isDescending;
  bool isChangeFormat;
  AttendantRecordBody({
    super.key,
    required this.snapshot,
    required this.items,
    required this.isDescending,
    required this.isChangeFormat,
  });

  @override
  State<AttendantRecordBody> createState() => _AttendantRecordBodyState();
}

class _AttendantRecordBodyState extends State<AttendantRecordBody> {
  List<AttendantModel> _foundAttendant = [];
  @override
  void initState() {
    _foundAttendant = widget.items;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<AttendantModel> result = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains with white-space,
      result = widget.items;
    } else {
      result = widget.items
          .map((items) => items)
          .where((element) => element.user!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();

      // Use toLowerCase() to make it case-insensitive
    }

    setState(() {
      _foundAttendant = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.data['data'].isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _foundAttendant.length + 1,
              itemBuilder: (context, index) {
                if (index < _foundAttendant.length) {
                  final sortedItems = _foundAttendant
                    ..sort(
                      (item1, item2) => widget.isDescending
                          ? item2.checkIn!.compareTo(item1.checkIn!)
                          : item1.checkIn!.compareTo(item2.checkIn!),
                    );
                  final item = sortedItems[index];

                  // Condition for Check-In
                  String convertToAgo(DateTime input) {
                    Duration diff = DateTime.now().difference(input);

                    if (diff.inHours >= 1) {
                      return '${diff.inHours} hour(s) ago';
                    } else {
                      return 'just now';
                    }
                  }

                  final DateTime from =
                      DateTime.parse(sortedItems[index].checkIn!);
                  final different = convertToAgo(from);

                  String formattedDate =
                      DateFormat('dd/MM/yyyy hh:mm a').format(from);

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ScaleTap(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewAttendantRecord(
                              attendantId: widget.snapshot.data['data'][index]
                                  ['id']),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name Display
                              Text(
                                'Name: ${item.user!}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.0),
                              // Phone Number Display
                              Text(
                                'Phone Number: ${item.phone!}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Check-In Display
                                  Text(
                                    'Check- In: ${widget.isChangeFormat ? formattedDate : different}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  // If the list on the last data
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text(
                        "You have reached the end of the list",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      );
    } else {
      return const BlankContent();
    }
  }
}
