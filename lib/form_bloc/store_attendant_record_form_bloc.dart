import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:vimigo_technical_interview/constant.dart';
import 'package:vimigo_technical_interview/helpers/validators.dart';
import 'package:vimigo_technical_interview/model/attendant_model.dart';
import 'package:vimigo_technical_interview/resources/attendant_resources.dart';

class StoreAttendantRecordFormBloc extends FormBloc<String, String> {
  final AttendantModel attendantModel = AttendantModel(
    checkIn: "",
    phone: "",
    user: "",
  );

  final name = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  final phoneNo = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.phoneNo,
    ],
  );

  final checkIn = InputFieldBloc<DateTime?, dynamic>(initialValue: null);

  StoreAttendantRecordFormBloc() {
    addFieldBlocs(fieldBlocs: [
      name,
      phoneNo,
      checkIn,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    attendantModel.user = name.value;
    attendantModel.phone = phoneNo.value;
    attendantModel.checkIn = checkIn.value.toString();

    AttendantResources().storeAttendant(
      uri: baseURL + attendantRecordURL,
      body: {
        "user": attendantModel.user,
        "phone": attendantModel.phone,
        "checkIn": attendantModel.checkIn,
      },
    );

    emitSuccess();
  }
}
