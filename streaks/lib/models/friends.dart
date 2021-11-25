class Friends {

  final List<String> friendList;

  Friends({
    this.friendList,
  });

  Friends.fromData(Map<String, dynamic> data)
      : friendList=data['friendList'];

  Map<String, dynamic> toJson() {
    return {
      'friendList': friendList,
    };
  }
}
