class TaskModel {
  String id;
  String title;
  String describtion;
  int date;
  bool isDone;
  String userId;
  TaskModel(
      {this.id = '',
      required this.title,
      required this.describtion,
      required this.date,
      this.isDone = false,
      required this.userId});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            describtion: json['describtion'],
            date: json['date'],
            userId: json['userId'],
            isDone: json['isDone']);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "describtion": describtion,
      "date": date,
      "isDone": isDone,
      "userId": userId,
    };
  }
}
