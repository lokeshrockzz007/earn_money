class Users {
  String username;

  String password;
  String email;
  String mobile;
  DateTime createDate;
  String userId;

  Users(this.username, this.password, this.email, this.mobile, this.createDate,
      this.userId);

  Users.fromJson(Map<String, dynamic> user) {
    this.username = user['username'];
    this.password = user['password'];
    this.email = user['email'];
    this.mobile = user['mobile'];
    this.createDate = user['create_date'];
    this.userId = user['user_id'];
  }
}
