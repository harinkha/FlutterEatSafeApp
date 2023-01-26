class Bookmark {

  String resName;
  Bookmark(
      this.resName,
      );
  Map<String, dynamic> toJson() =>
      {
        'resName': resName,
      };

}