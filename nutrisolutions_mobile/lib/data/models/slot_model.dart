class SlotModel {
  final DateTime date;
  final String day;
  final String time;
  final String nutritionistName;
  final bool isReservation;
  final bool isReserved;
  final double rating;
  final String? clientName;
  final List<String>? notes;
  final String? id;

  SlotModel({
    required this.date,
    required this.day,
    required this.time,
    required this.nutritionistName,
    required this.isReservation,
    required this.isReserved,
    required this.rating,
    this.clientName,
    this.notes,
    this.id,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      date: DateTime.parse(json['date']),
      day: json['day'],
      time: json['time'],
      nutritionistName: json['nutritionist']['name'], // adjust as needed
      isReservation: json['isReservation'],
      isReserved: json['isReserved'],
      rating: json['rating'].toDouble(),
      clientName: json['client']?['name'],
      notes: List<String>.from(json['notes'] ?? []),
      id: json['id'],
    );
  }
}
