class UserTypeModel {
  final String? uid;
  final String? name;
  final String? description;

  const UserTypeModel({
    this.uid,
    this.name,
    this.description,
  });

  factory UserTypeModel.fromJson(Map<String, dynamic> json) {
    return UserTypeModel(
      uid: json['uid'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
    };
  }
}
