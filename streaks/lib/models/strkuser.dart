class StrkUser {
   final String id;
  final String fullName;
  final String email;
  

  StrkUser({
    this.id,
    this.fullName,
    this.email,
    
  });

  StrkUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'];
        

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email
    };
  }
}
