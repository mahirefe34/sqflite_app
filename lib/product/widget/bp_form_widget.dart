import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BPFormWidget extends StatelessWidget {
  final String _customErrorText = 'Please enter correct data';
  final String _systolicText = 'SYSTOLIC';
  final String _diastolicText = 'DIASTOLIC';
  final String _pulseText = 'PULSE';
  final String _saveText = 'SAVE';
  final String _mmHg = 'mmHg';
  final String _sysText = 'SYS';
  final String _diaText = 'DIA';
  final String _minituText = 'minute';
  final String _title = 'ADD BLOOD PRESSURE';

  final String? systolic;
  final String? diastolic;
  final String? pulse;
  final String? description;
  final ValueChanged<String> onChangedSystolic;
  final ValueChanged<String> onChangedDiastolic;
  final ValueChanged<String> onChangedPulse;
  final ValueChanged<String> onChangedDescription;

  const BPFormWidget({
    Key? key,
    this.systolic = '',
    this.diastolic = '',
    this.pulse = '',
    this.description = '',
    required this.onChangedSystolic,
    required this.onChangedDiastolic,
    required this.onChangedPulse,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSystolic(),
              const SizedBox(height: 8),
              buildDiastolic(),
              const SizedBox(height: 8),
              buildPulse(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildSystolic() => TextFormField(
        maxLines: 1,
        maxLength: 3,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
        initialValue: systolic,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: _sysText,
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        validator: (String? inputValue) {
          if (inputValue == null || inputValue.length < 2) {
            return _customErrorText;
          }
          return null;
        },
        onChanged: onChangedSystolic,
      );

  Widget buildDiastolic() => TextFormField(
        maxLines: 1,
        maxLength: 3,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
        initialValue: diastolic,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: _diaText,
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        validator: (String? inputValue) {
          if (inputValue == null || inputValue.length < 2) {
            return _customErrorText;
          }
          return null;
        },
        onChanged: onChangedDiastolic,
      );

  Widget buildPulse() => TextFormField(
        maxLines: 1,
        maxLength: 3,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
        initialValue: pulse,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: _pulseText,
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        validator: (String? inputValue) {
          if (inputValue == null || inputValue.length < 2) {
            return _customErrorText;
          }
          return null;
        },
        onChanged: onChangedPulse,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: 'Type something...',
          hintStyle: const TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}
