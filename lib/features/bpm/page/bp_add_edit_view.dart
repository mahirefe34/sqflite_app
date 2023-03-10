import 'package:flutter/material.dart';
import 'package:sqflite_app/features/bpm/db/bp_database.dart';
import 'package:sqflite_app/features/bpm/model/bp_model.dart';
import 'package:sqflite_app/product/mixin/navigator_mixin.dart';
import '../../../product/widget/bp_form_widget.dart';

class BPAddEditPage extends StatefulWidget {
  final BPModel? model;

  const BPAddEditPage({
    Key? key,
    this.model,
  }) : super(key: key);
  @override
  _BPAddEditPageState createState() => _BPAddEditPageState();
}

class _BPAddEditPageState extends State<BPAddEditPage> with NavigatorMixin {
  final _formKey = GlobalKey<FormState>();
  late String systolic;
  late String diastolic;
  late String pulse;
  late String description;

  @override
  void initState() {
    super.initState();
    systolic = widget.model?.systolic ?? '';
    diastolic = widget.model?.diastolic ?? '';
    pulse = widget.model?.pulse ?? '';
    description = widget.model?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: BPFormWidget(
            systolic: systolic,
            diastolic: diastolic,
            pulse: pulse,
            description: description,
            onChangedSystolic: (systolic) =>
                setState(() => this.systolic = systolic),
            onChangedDiastolic: (diastolic) =>
                setState(() => this.diastolic = diastolic),
            onChangedPulse: (pulse) => setState(() => this.pulse = pulse),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = systolic.isNotEmpty &&
        diastolic.isNotEmpty &&
        pulse.isNotEmpty &&
        description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateBP,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateBP() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.model != null;

      if (isUpdating) {
        await updateBP();
      } else {
        await addBP();
      }

      router.popToPage();
    }
  }

  Future updateBP() async {
    final model = widget.model!.copy(
      systolic: systolic,
      diastolic: diastolic,
      pulse: pulse,
      description: description,
    );

    await BPDatabase.instance.update(model);
  }

  Future addBP() async {
    final model = BPModel(
      systolic: systolic,
      diastolic: diastolic,
      pulse: pulse,
      status: 0,
      description: description,
      createdTime: DateTime.now(),
    );

    await BPDatabase.instance.create(model);
  }
}
