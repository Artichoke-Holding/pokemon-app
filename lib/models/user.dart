import 'name.dart';
import 'location.dart';
import 'job.dart';
import 'last_login.dart';

class User {

  User({
    this.uuid,
    this.objectId,
    this.status,
    this.name,
    this.username,
    this.nikeName,
    this.avatar,
    this.emails,
    this.phoneNumber,
    this.location,
    this.website,
    this.domain,
    this.job,
    this.lastLogin,
  });

  User.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'] as String? ?? '';
    objectId = json['objectId'] as String? ?? '';
    status = json['status'] as String? ?? '';
    name = json['name'] != null
        ? Name.fromJson(json['name'] as Map<String, dynamic>? ?? {})
        : null;
    username = json['username'] as String? ?? '';
    nikeName = json['nikeName'] as String? ?? '';
    avatar = json['avatar'] as String? ?? '';
    if (json['emails'] != null) {
      emails = [];
      for (final v in json['emails']  as List<dynamic>? ?? []) {
        emails!.add(v as String? ?? '');
      }
    }
    phoneNumber = json['phoneNumber'] as String? ?? '';
    location = json['location'] != null
        ? Location.fromJson(json['location'] as Map<String, dynamic>? ?? {})
        : null;
    website = json['website'] as String? ?? '';
    domain = json['domain'] as String? ?? '';
    job = json['job'] != null
        ? Job.fromJson(json['job'] as Map<String, dynamic>? ?? {})
        : null;
    lastLogin = json['lastLogin'] != null
        ? LastLogin.fromJson(json['lastLogin'] as Map<String, dynamic>? ?? {})
        : null;
  }

  String? uuid;
  String? objectId;
  String? status;
  Name? name;
  String? username;
  String? nikeName;
  String? avatar;
  List<String>? emails;
  String? phoneNumber;
  Location? location;
  String? website;
  String? domain;
  Job? job;
  LastLogin? lastLogin;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['objectId'] = objectId;
    data['status'] = status;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['username'] = username;
    data['nikeName'] = nikeName;
    data['avatar'] = avatar;
    if (emails != null) {
      data['emails'] = emails!.map((v) => v).toList();
    }
    data['phoneNumber'] = phoneNumber;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['website'] = website;
    data['domain'] = domain;
    if (job != null) {
      data['job'] = job!.toJson();
    }
    if (lastLogin != null) {
      data['lastLogin'] = lastLogin!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'user{'
        'uuid: $uuid, '
        'objectId: $objectId, '
        'status: $status, '
        'name: $name, '
        'username: $username, '
        'nikeName: $nikeName, '
        'avatar: $avatar, '
        'emails: $emails, '
        'phoneNumber: $phoneNumber, '
        'location: $location, '
        'website: $website, '
        'domain: $domain, '
        'job: $job, '
        'lastLogin: $lastLogin, '
        '}';
  }
  String? get firstEmail => emails?.isNotEmpty == true ? emails!.first : null;

}





