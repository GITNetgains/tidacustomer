// To parse this JSON data, do
//
//     final tournamentList = tournamentListFromJson(jsonString);

import 'dart:convert';


TournamentList? tournamentListFromJson(String str) => TournamentList.fromJson(json.decode(str));

String tournamentListToJson(TournamentList? data) => json.encode(data!.toJson());

class TournamentList {
    TournamentList({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum?>? data;

    factory TournamentList.fromJson(Map<String, dynamic> json) => TournamentList(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : json["data"] is List ? List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))):[],
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
        this.academyId,
        this.title,
        this.noOfTickets,
        this.ticketsLeft,
        this.price,
        this.startDate,
        this.endDate,
        this.description,
        this.type,
        this.image,
        this.url,
        this.approved,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.academyDetails,
        this.sponsors,
        this.rating,
        this.is_like,
    });

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
    String? image;
    String? url;
    String? approved;
    String? status;
    dynamic is_like;
    String? createdAt;
    String? updatedAt;
    List<AcademyDetail?>? academyDetails;
    List<RatingElement>? rating;
    List<Sponsors>? sponsors;


    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        academyId: json["academy_id"],
        title: json["title"]??"",
        noOfTickets: json["no_of_tickets"],
        ticketsLeft: json["tickets_left"],
        price: json["price"]??"",
        startDate: json["start_date"]??"",
        endDate: json["end_date"],
        description: json["description"]??"",
        type: json["type"],
        image: json["image"],
        url: json["url"],
        approved: json["approved"],
        status: json["status"],
        is_like: json["is_like"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        academyDetails: json["academy_details"] == null ? [] : json["academy_details"] is List ? List<AcademyDetail?>.from(json["academy_details"]!.map((x) => AcademyDetail.fromJson(x))):[],
        rating: json["rating"] == null ? [] : json["rating"] is List ? List<RatingElement>.from(json["rating"]!.map((x) => RatingElement.fromJson(x))):[],
        sponsors: json["sponsors"] == null ? [] : json["sponsors"] is List ? List<Sponsors>.from(json["sponsors"]!.map((x) => Sponsors.fromJson(x))):[],
    );


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
        "image": image,
        "url": url,
        "approved": approved,
        "status": status,
        "is_like": is_like,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "academy_details": academyDetails == null ? [] : academyDetails == null ? [] : List<dynamic>.from(academyDetails!.map((x) => x!.toJson())),
        "sponsors": sponsors == null ? [] : sponsors == null ? [] : List<dynamic>.from(sponsors!.map((x) => x!.toJson())),
    };
}
class Sponsors {
    String? id;
    String? name;
    String? website;
    String? contact;
    String? status;
    String? createdAt;
    String? updatedAt;

    Sponsors(
        {this.id,
            this.name,
            this.website,
            this.contact,
            this.status,
            this.createdAt,
            this.updatedAt});

    Sponsors.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        name = json['name'];
        website = json['website'];
        contact = json['contact'];
        status = json['status'];
        createdAt = json['created_at'];
        updatedAt = json['updated_at'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['website'] = this.website;
        data['contact'] = this.contact;
        data['status'] = this.status;
        data['created_at'] = this.createdAt;
        data['updated_at'] = this.updatedAt;
        return data;
    }
}
class AcademyDetail {
    AcademyDetail({
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

    factory AcademyDetail.fromJson(Map<String, dynamic> json) => AcademyDetail(
        id: json["id"],
        userId: json["user_id"],
        venueId: json["venue_id"],
        name: json["name"]??"",
        address: json["address"]??"",
        logo: json["logo"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        description: json["description"]??"",
        contactNo: json["contact_no"]??"",
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

