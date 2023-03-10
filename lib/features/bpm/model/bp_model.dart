const String tableBP = 'bp';

class BPModelFields {
  static final List<String> values = [
    /// Add all fields
    id, status, systolic, diastolic, pulse, description, time
  ];

  static const String id = '_id';
  static const String status = 'status';
  static const String systolic = 'systolic';
  static const String diastolic = 'diastolic';
  static const String pulse = 'pulse';
  static const String description = 'description';
  static const String time = 'time';
}

class BPModel {
  final int? id;
  final int status;
  final String systolic;
  final String diastolic;
  final String pulse;
  final String description;
  final DateTime createdTime;

  const BPModel({
    this.id,
    required this.status,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.description,
    required this.createdTime,
  });

  BPModel copy({
    int? id,
    int? status,
    String? systolic,
    String? diastolic,
    String? pulse,
    String? description,
    DateTime? createdTime,
  }) =>
      BPModel(
        id: id ?? this.id,
        status: status ?? this.status,
        systolic: systolic ?? this.systolic,
        diastolic: diastolic ?? this.diastolic,
        pulse: pulse ?? this.pulse,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static BPModel fromJson(Map<String, Object?> json) => BPModel(
        id: json[BPModelFields.id] as int?,
        status: json[BPModelFields.status] as int,
        systolic: json[BPModelFields.systolic] as String,
        diastolic: json[BPModelFields.diastolic] as String,
        pulse: json[BPModelFields.pulse] as String,
        description: json[BPModelFields.description] as String,
        createdTime: DateTime.parse(json[BPModelFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        BPModelFields.id: id,
        BPModelFields.status: status,
        BPModelFields.systolic: systolic,
        BPModelFields.diastolic: diastolic,
        BPModelFields.pulse: pulse,
        BPModelFields.description: description,
        BPModelFields.time: createdTime.toIso8601String(),
      };
}
