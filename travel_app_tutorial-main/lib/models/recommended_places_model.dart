class Post {
  final String? id;
  final String? name;
  final String? location;
  final String? placeImage;
  final String? star;
  final String? about;
  final String? type;

  Post({
    this.id,
    this.name,
    this.location,
    this.placeImage,
    this.star,
    this.about,
    this.type,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      placeImage: json['place_image'],
      star: json['star']?.toString(),
      about: json['about'],
      type: json['type'],
    );
  }
}
