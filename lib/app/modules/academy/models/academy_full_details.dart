// To parse this JSON data, do
//
//     final academyFullDetailResponse = academyFullDetailResponseFromJson(jsonString);

import 'dart:convert';

AcademyFullDetailResponse? academyFullDetailResponseFromJson(String str) => AcademyFullDetailResponse.fromJson(json.decode(str));

String academyFullDetailResponseToJson(AcademyFullDetailResponse? data) => json.encode(data!.toJson());

class AcademyFullDetailResponse {
    AcademyFullDetailResponse({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum?>? data;

    factory AcademyFullDetailResponse.fromJson(Map<String, dynamic> json) => AcademyFullDetailResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : json["data"] is List ? List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))) :[],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    };
}

class Datum {
    Datum({
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
        this.createdAt,
        this.updatedAt,
        this.packages,
        this.amenitiesDetails,
        this.venueDetails,
        this.rating
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
    List<Package>? packages;
    List<RatingElement>? rating;
    List<AmenitiesDetail?>? amenitiesDetails;
    List<VenueDetail?>? venueDetails;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        venueId: json["venue_id"],
        name: json["name"]??"",
        address: json["address"]??"",
        logo: json["logo"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        description: json["description"]??"",
        contactNo: json["contact_no"]??"0000000000",
        headCoach: json["head_coach"],
        sessionTimings: json["session_timings"],
        weekDays: json["week_days"]??"",
        price: json["price"]??"",
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
        coachExperience: json["coach_experience"],
        noOfAssistentCoach: json["no_of_assistent_coach"],
        assistentCoachName: json["assistent_coach_name"],
        feedbacks: json["feedbacks"],
        amenitiesId: json["amenities_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        packages: json["packages"] == null ? [] : json["packages"] is List ? List<Package>.from(json["packages"]!.map((x) => Package.fromJson(x))):[],
        amenitiesDetails: json["amenities_details"] == null ? [] : json["amenities_details"] is List ? List<AmenitiesDetail?>.from(json["amenities_details"]!.map((x) => AmenitiesDetail.fromJson(x))):[] ,
        venueDetails: json["venue_details"] == null ? [] : json["venue_details"] is List ? List<VenueDetail?>.from(json["venue_details"]!.map((x) => VenueDetail.fromJson(x))):[] ,
        rating: json["rating"] == null ? [] : json["rating"] is List ? List<RatingElement>.from(json["rating"]!.map((x) => RatingElement.fromJson(x))):[],
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
        "amenities_details": amenitiesDetails == null ? [] : amenitiesDetails == null ? [] : List<dynamic>.from(amenitiesDetails!.map((x) => x!.toJson())),
        "venue_details": venueDetails == null ? [] : venueDetails == null ? [] : List<dynamic>.from(venueDetails!.map((x) => x!.toJson())),
    };
}

class Package {
    Package({
        this.id,
        this.title,
        this.price,
        this.academy,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? title;
    String? price;
    String? academy;
    String? description;
    String? createdAt;
    String? updatedAt;

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        title: json["title"]??"",
        price: json["price"]??"",
        academy: json["academy"]??"",
        description: json["description"]??"",
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "academy": academy,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}


class AmenitiesDetail {
    AmenitiesDetail({
        this.id,
        this.name,
        this.icon,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? name;
    String? icon;
    String? status;
    String? createdAt;
    String? updatedAt;

    factory AmenitiesDetail.fromJson(Map<String, dynamic> json) => AmenitiesDetail(
        id: json["id"],
        name: json["name"]??"",
        icon: json["icon"]??"",
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class VenueDetail {
    VenueDetail({
        this.id,
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
    });

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

    factory VenueDetail.fromJson(Map<String, dynamic> json) => VenueDetail(
        id: json["id"],
        userId: json["user_id"],
        image: json["image"],
        title: json["title"]??"",
        sports: json["sports"]??"",
        amenities: json["amenities"],
        description: json["description"]??"",
        address: json["address"]??"",
        addressMap: json["address_map"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        rating: json["rating"]??"1",
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
