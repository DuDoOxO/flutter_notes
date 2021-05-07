// add dependencies :
// json_annotation: ^3.1.1
// add dev_dependencies :
// build_runner: ^1.0.0
// json_serializable: ^3.5.1

import 'package:json_annotation/json_annotation.dart';

// permit User去存取這些產生的檔案中的私有成員
part 'user_model.g.dart';

// 該修飾符是告訴生成器,該class是用來產生Model的
@JsonSerializable()

class User {
  User(this.name, this.phone);
  final String name;

// if input key of map is phone_number, we can add `@JsonKey` to transform, phone_number -> phone
  //@JsonKey(name:"phone_number")
  final String phone;

//  factory 修飾子要有,為了從Map來創建一個User instance
// 把整個Map傳進`_$UserFromJson()` func中
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

// `toJson` 是用來限制即將進行序列化為JSON
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
