// To parse this JSON data, do
//
//     final nearbyDataResponse = nearbyDataResponseFromJson(jsonString);

import 'dart:convert';

NearbyDataResponse? nearbyDataResponseFromJson(String str) =>
    NearbyDataResponse.fromJson(json.decode(str));

String nearbyDataResponseToJson(NearbyDataResponse? data) =>
    json.encode(data!.toJson());

class NearbyDataResponse {
  NearbyDataResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory NearbyDataResponse.fromJson(Map<String, dynamic> json) =>
      NearbyDataResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] is List
            ? Data.fromJson({})
            : Data.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}

class Data {
  Data({
    this.venue,
    this.academy,
    this.experience,
    this.tournament,
  });

  List<Venue?>? venue;
  List<Academy?>? academy;
  List<Experience?>? experience;
  List<Tournament?>? tournament;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        venue: json["venue"] == null
            ? json["venue"] is int
                ? []
                : []
            : json["venue"] == null
                ? json["venue"] is int
                    ? []
                    : []
                : json["venue"] is int
                    ? []
                    : List<Venue?>.from(
                        json["venue"]!.map((x) => Venue.fromJson(x))),
        academy: json["academy"] == null
            ? json["academy"] is int
                ? []
                : []
            : json["academy"] == null
                ? json["academy"] is int
                    ? []
                    : []
                : json["academy"] is int
                    ? []
                    : List<Academy?>.from(
                        json["academy"]!.map((x) => Academy.fromJson(x))),
        experience: json["experience"] == null
            ? json["experience"] is int
                ? []
                : []
            : json["experience"] == null
                ? json["experience"] is int
                    ? []
                    : []
                : json["experience"] is int
                    ? []
                    : List<Experience?>.from(
                        json["experience"]!.map((x) => Experience.fromJson(x))),
        tournament: json["tournament"] == null
            ? json["tournament"] is int
                ? []
                : []
            : json["tournament"] == null
                ? json["tournament"] is int
                    ? []
                    : []
                : json["tournament"] is int
                    ? []
                    : List<Tournament?>.from(
                        json["tournament"]!.map((x) => Tournament.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "venue": venue == null
            ? []
            : venue == null
                ? []
                : List<dynamic>.from(venue!.map((x) => x!.toJson())),
        "academy": academy == null
            ? []
            : academy == null
                ? []
                : List<dynamic>.from(academy!.map((x) => x!.toJson())),
        "experience": experience == null
            ? []
            : experience == null
                ? []
                : List<dynamic>.from(experience!.map((x) => x!.toJson())),
        "tournament": tournament == null
            ? []
            : tournament == null
                ? []
                : List<dynamic>.from(tournament!.map((x) => x!.toJson())),
      };
}

class Academy {
  Academy({
    this.id,
    this.userId,
    this.venueId,
    this.name,
    this.address,
    this.logo,
    this.latitude,
    this.longitude,
    this.description,
    this.contactNo,
    this.headCoach,
    this.sessionTimings,
    this.weekDays,
    this.price,
    this.remarksPrice,
    this.skillLevel,
    this.academyJersey,
    this.capacity,
    this.remarksCurrentCapacity,
    this.sessionPlan,
    this.remarksSessionPlan,
    this.ageGroupOfStudents,
    this.remarksStudents,
    this.equipment,
    this.remarksOnEquipment,
    this.floodLights,
    this.groundSize,
    this.person,
    this.coachExperience,
    this.noOfAssistentCoach,
    this.assistentCoachName,
    this.feedbacks,
    this.amenitiesId,
    this.status,
    this.distance,
    this.createdAt,
    this.updatedAt,
    this.rating,
  });

  String? id;
  String? userId;
  String? venueId;
  String? name;
  String? address;
  String? logo;
  dynamic latitude;
  dynamic longitude;
  String? description;
  String? contactNo;
  String? headCoach;
  String? sessionTimings;
  String? weekDays;
  String? price;
  String? remarksPrice;
  String? skillLevel;
  String? academyJersey;
  String? capacity;
  String? remarksCurrentCapacity;
  String? sessionPlan;
  String? distance;
  String? remarksSessionPlan;
  String? ageGroupOfStudents;
  String? remarksStudents;
  String? equipment;
  String? remarksOnEquipment;
  String? floodLights;
  String? groundSize;
  String? person;
  String? coachExperience;
  String? noOfAssistentCoach;
  String? assistentCoachName;
  String? feedbacks;
  String? amenitiesId;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<RatingElement>? rating;

  factory Academy.fromJson(Map<String, dynamic> json) => Academy(
        id: json["id"],
        userId: json["user_id"],
        venueId: json["venue_id"],
        name: json["name"],
        address: json["address"],
        logo: json["logo"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        description: json["description"],
        contactNo: json["contact_no"],
        headCoach: json["head_coach"],
        sessionTimings: json["session_timings"],
        weekDays: json["week_days"],
        price: json["price"],
        remarksPrice: json["remarks_price"],
        skillLevel: json["skill_level"],
        academyJersey: json["academy_jersey"],
        capacity: json["capacity"],
        remarksCurrentCapacity: json["remarks_current_capacity"],
        sessionPlan: json["session_plan"],
        remarksSessionPlan: json["remarks_session_plan"],
        ageGroupOfStudents: json["age_group_of_students"],
        remarksStudents: json["remarks_students"],
        equipment: json["equipment"],
        remarksOnEquipment: json["remarks_on_equipment"],
        floodLights: json["flood_lights"],
        groundSize: json["ground_size"],
        person: json["person"],
        distance: json["distance"],
        coachExperience: json["coach_experience"],
        noOfAssistentCoach: json["no_of_assistent_coach"],
        assistentCoachName: json["assistent_coach_name"],
        feedbacks: json["feedbacks"],
        amenitiesId: json["amenities_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        rating: json["rating"] == null
            ? []
            : json["rating"] is List
                ? List<RatingElement>.from(
                    json["rating"]!.map((x) => RatingElement.fromJson(x)))
                : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "venue_id": venueId,
        "name": name,
        "address": address,
        "logo": logo,
        "latitude": latitude,
        "longitude": longitude,
        "description": description,
        "contact_no": contactNo,
        "head_coach": headCoach,
        "session_timings": sessionTimings,
        "week_days": weekDays,
        "price": price,
        "distance": distance,
        "remarks_price": remarksPrice,
        "skill_level": skillLevel,
        "academy_jersey": academyJersey,
        "capacity": capacity,
        "remarks_current_capacity": remarksCurrentCapacity,
        "session_plan": sessionPlan,
        "remarks_session_plan": remarksSessionPlan,
        "age_group_of_students": ageGroupOfStudents,
        "remarks_students": remarksStudents,
        "equipment": equipment,
        "remarks_on_equipment": remarksOnEquipment,
        "flood_lights": floodLights,
        "ground_size": groundSize,
        "person": person,
        "coach_experience": coachExperience,
        "no_of_assistent_coach": noOfAssistentCoach,
        "assistent_coach_name": assistentCoachName,
        "feedbacks": feedbacks,
        "amenities_id": amenitiesId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Experience {
  Experience({
    this.id,
    this.title,
    this.description,
    this.price,
    this.venueId,
    this.image,
    this.status,
    this.distance,
    this.createdAt,
    this.updatedAt,
    this.rating,
  });

  String? id;
  String? title;
  String? description;
  String? price;
  String? venueId;
  String? image;
  String? status;
  String? distance;
  String? createdAt;
  String? updatedAt;
  List<RatingElement>? rating;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        venueId: json["venue_id"],
        image: json["image"],
        status: json["status"],
        distance: json["distance"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        rating: json["rating"] == null
            ? []
            : json["rating"] is List
                ? List<RatingElement>.from(
                    json["rating"]!.map((x) => RatingElement.fromJson(x)))
                : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "venue_id": venueId,
        "image": image,
        "status": status,
        "distance": distance,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Venue {
  Venue(
      {this.id,
      this.userId,
      this.image,
      this.title,
      this.sports,
      this.amenities,
      this.description,
      this.address,
      this.addressMap,
      this.latitude,
      this.longitude,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.distance,
      this.rating});

  String? id;
  String? userId;
  String? image;
  String? title;
  String? sports;
  String? amenities;
  String? description;
  String? address;
  String? addressMap;
  String? latitude;
  String? longitude;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? distance;
  List<RatingElement>? rating;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        userId: json["user_id"],
        image: json["image"],
        title: json["title"],
        sports: json["sports"],
        amenities: json["amenities"],
        description: json["description"],
        address: json["address"],
        addressMap: json["address_map"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        distance: json["distance"],
        rating: json["rating"] == null
            ? []
            : json["rating"] is List
                ? List<RatingElement>.from(
                    json["rating"]!.map((x) => RatingElement.fromJson(x)))
                : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "image": image,
        "title": title,
        "sports": sports,
        "amenities": amenities,
        "description": description,
        "address": address,
        "address_map": addressMap,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "distance": distance,
      };
}

class Tournament {
  Tournament(
      {this.id,
      this.userId,
      this.academyId,
      this.title,
      this.noOfTickets,
      this.ticketsLeft,
      this.price,
      this.startDate,
      this.endDate,
      this.description,
      this.type,
      this.url,
      this.approved,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.rating,
      this.image});

  String? id;
  String? userId;
  String? academyId;
  String? title;
  String? noOfTickets;
  String? ticketsLeft;
  String? price;
  String? startDate;
  String? endDate;
  String? description;
  String? type;
  dynamic url;
  String? approved;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? image;
  List<RatingElement>? rating;

  factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
      id: json["id"],
      userId: json["user_id"],
      academyId: json["academy_id"],
      title: json["title"],
      noOfTickets: json["no_of_tickets"],
      ticketsLeft: json["tickets_left"],
      price: json["price"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      description: json["description"],
      type: json["type"],
      url: json["url"],
      approved: json["approved"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      image: json["image"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "academy_id": academyId,
        "title": title,
        "no_of_tickets": noOfTickets,
        "tickets_left": ticketsLeft,
        "price": price,
        "start_date": startDate,
        "end_date": endDate,
        "description": description,
        "type": type,
        "url": url,
        "approved": approved,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class RatingElement {
  RatingElement({
    this.id,
    this.userId,
    this.review,
    this.rating,
    this.postType,
    this.postId,
    this.status,
    this.createdAt,
  });

  String? id;
  String? userId;
  String? review;
  String? rating;
  String? postType;
  String? postId;
  String? status;
  String? createdAt;

  factory RatingElement.fromJson(Map<String, dynamic> json) => RatingElement(
        id: json["id"],
        userId: json["user_id"],
        review: json["review"],
        rating: json["rating"] ?? "1",
        postType: json["post_type"],
        postId: json["post_id"],
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "review": review,
        "rating": rating,
        "post_type": postType,
        "post_id": postId,
        "status": status,
        "created_at": createdAt,
      };
}
