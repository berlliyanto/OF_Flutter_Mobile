class Links {
  final String first, last;
  final dynamic next, prev;

  Links(
      {required this.first,
      required this.last,
      required this.prev,
      required this.next});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"]);
  }
}

class Meta {
  final int currentPage, lastPage, perPage, total;
  final dynamic from, to;
  final String path;
  final dynamic links;

  Meta(
      {required this.currentPage,
      required this.from,
      required this.lastPage,
      required this.perPage,
      required this.to,
      required this.path,
      required this.total,
      required this.links});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["current_page"],
      from: json["from"],
      lastPage: json["last_page"],
      perPage: json["per_page"],
      to: json["to"],
      path: json["path"],
      total: json["total"],
      links: json["links"],
    );
  }
}
