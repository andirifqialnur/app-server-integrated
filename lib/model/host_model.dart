class HostModel {
  int? id;
  String? ip_add;
  String? username;
  String? password;
  String? ticket;

  HostModel({
    this.id,
    this.ip_add,
    this.username,
    this.password,
    this.ticket,
  });

  HostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ip_add = json['ip_address'];
    username = json['username'];
    password = json['password'];
    ticket = json['ticket'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ip_address': ip_add,
      'username': username,
      'password': password,
      'ticket': ticket,
    };
  }
}
