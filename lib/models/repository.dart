class Repository {
  final String name;
  final String description;
  final String htmlUrl;

  Repository(this.name, this.description, this.htmlUrl);

  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description, 'html_url': htmlUrl};

  Repository.fromJson(Map json)
      : name = json['name'],
        description = json['description'],
        htmlUrl = json['html_url'];
}
