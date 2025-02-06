class CreateTaskModel {
  String title;
  String description;
  String? status;
  String deliveryDate;
  String? priority;

  CreateTaskModel({
    required this.title,
    required this.description,
    this.status,
    required this.deliveryDate,
    this.priority,
  });
}
