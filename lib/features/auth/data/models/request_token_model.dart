class RequestTokenModel {
  late final String? token;

  RequestTokenModel({
    this.token,
  });

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
