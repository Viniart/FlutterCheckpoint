class Organization {
  final String name;
  final String htmlUrl;

  Organization(this.name, this.htmlUrl);

  Map<String, dynamic> toJson() =>
      {'name': name, 'html_url': htmlUrl};

  Organization.fromJson(Map json)
      : name = json['name'],
        htmlUrl = json['html_url'];
}
