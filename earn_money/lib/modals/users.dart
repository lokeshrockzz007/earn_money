class Users {
  String username;
  String password;
  String email;
  String mobile;
  String createDate;
  String userId;
  String userType;
  String refCode;
  String targetUserId;
  String status;
  Users(
      {this.username,
      this.password,
      this.email,
      this.mobile,
      this.createDate,
      this.userId,
      this.userType,
      this.status});

  Users.fromJson(Map<String, dynamic> user) {
    this.username = user['username'];
    this.password = user['password'];
    this.status = user['status'];
    this.email = user['email'];
    this.mobile = user['mobile'];
    this.createDate = user['create_date'];
    this.userId = user['user_id'];
    this.userType = user['userType'];
    this.refCode = user['refCode'];
  }

  Map<String, dynamic> toJson() => {
        'username': this.username,
        'password': this.password,
        'email': this.email,
        'mobile': this.mobile,
        'create_date': this.createDate,
        'user_id': this.userId,
        'userType': this.userType,
        'refCode': this.refCode,
        'status': this.status
      };
}
