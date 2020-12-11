
class User{
   String id;
   String name;
   String description;
   String username;
   String profileImageUrl;

  User({
  this.id,
  this.name,
  this.description,
  this.username,
  this.profileImageUrl,
  });

   factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      description: json['description'],
      name: json['name'],
      username: json['username'],
      profileImageUrl: json['profile_image_url'],

    );
  }

}