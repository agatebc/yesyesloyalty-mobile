import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
	int? id;
	String? name;
	String? location;
	bool? active;
	String? address;
	String? coordinates;
	@JsonKey(name: 'email_1') 
	String? email1;
	@JsonKey(name: 'email_2') 
	dynamic email2;
	@JsonKey(name: 'phone_1') 
	String? phone1;
	@JsonKey(name: 'phone_2') 
	dynamic phone2;
	@JsonKey(name: 'created_at') 
	DateTime? createdAt;
	@JsonKey(name: 'updated_at') 
	DateTime? updatedAt;
	@JsonKey(name: 'deleted_at') 
	dynamic deletedAt;

	Data({
		this.id, 
		this.name, 
		this.location, 
		this.active, 
		this.address, 
		this.coordinates, 
		this.email1, 
		this.email2, 
		this.phone1, 
		this.phone2, 
		this.createdAt, 
		this.updatedAt, 
		this.deletedAt, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

	Map<String, dynamic> toJson() => _$DataToJson(this);
}
