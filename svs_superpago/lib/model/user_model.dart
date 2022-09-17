class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;

  UserModel({this.uid, this.email, this.firstName, this.lastName});

  // Recibiendo datos desde el servidor
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['correo'],
      firstName: map['nombres'],
      lastName: map['apellidos'],
    );
  }

  // Enviando datos al servidor
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'correo': email,
      'nombres': firstName,
      'apellidos': lastName,
    };
  }
}
