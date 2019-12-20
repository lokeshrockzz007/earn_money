class Users {
  String username;
  String password;
  String email;
  String mobile;
  String createDate;
  String userId;
  String userType;
  Users(
      {this.username,
      this.password,
      this.email,
      this.mobile,
      this.createDate,
      this.userId});

  Users.fromJson(Map<String, dynamic> user) {
    this.username = user['username'];
    this.password = user['password'];
    this.email = user['email'];
    this.mobile = user['mobile'];
    this.createDate = user['create_date'];
    this.userId = user['user_id'];
    this.userType = user['userType'];
  }

  Map<String, dynamic> toJson() => {
        'username': this.username,
        'password': this.password,
        'email': this.email,
        'mobile': this.mobile,
        'create_date': this.createDate,
        'user_id': this.userId,
        'userType': this.userType,
      };
}
