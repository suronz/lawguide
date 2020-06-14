
class RegisterUser { 

  
  String id;
  String username;
  String mobile;
  String email;
  String country;
  String city;
  String state;
  String pincode;
  String usertype;
  String profilepic;
  String occupation;
  String occupationId;
  

  RegisterUser({
    this.id,
    this.username,
    this.mobile,
    this.email,
    this.country,
    this.city,
    this.state,
    this.pincode,
    this.usertype,
    this.profilepic,
    this.occupation,
    this.occupationId,
  });

  Map toMap(RegisterUser user){
    var data = Map<String, dynamic>();
    data['id'] = user.id;
    data['username'] = user.username;
    data['email'] = user.email;
    data['mobile'] = user.mobile;
    data['country'] = user.country;
    data['city'] = user.city;
    data['state'] = user.state;
    data['pincode'] = user.pincode;
    data['usertype'] = user.usertype;
    data['profilepic'] = user.profilepic;
    data['occupation'] = user.occupation;
    data['occupationId'] = user.occupationId;

    return data;

  }

  RegisterUser.fromMap(Map<String,dynamic> mapData) {

    this.id = mapData['id'];
    this.username = mapData['username'];
    this.email = mapData['email'];
    this.mobile = mapData['mobile']; 
    this.country = mapData['country'];
    this.city = mapData['city']; 
    this.state = mapData['state'];
    this.pincode = mapData['pincode'];
    this.usertype = mapData['usertype'];
    this.profilepic = mapData['profilepic'];
    this.occupation = mapData['occupation'];
    this.occupationId = mapData['occupationId'];
    
  }

 
}