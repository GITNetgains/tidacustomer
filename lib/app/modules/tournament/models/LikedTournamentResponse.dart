class LikeResponseModel {
    LikeResponseModel({
        required this.status,
        required this.message,
        required this.data,
    });

    final bool? status;
    final String? message;
    final Data? data;

    factory LikeResponseModel.fromJson(Map<String, dynamic> json){ 
        return LikeResponseModel(
            status: json["status"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.tournaments,
    });

    final List<Tournament> tournaments;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            tournaments: json["tournaments"] == null ? [] : List<Tournament>.from(json["tournaments"]!.map((x) => Tournament.fromJson(x))),
        );
    }

}

class Tournament {
    Tournament({
        required this.id,
        required this.userId,
        required this.academyId,
        required this.title,
        required this.noOfTickets,
        required this.ticketsLeft,
        required this.price,
        required this.startDate,
        required this.endDate,
        required this.description,
        required this.type,
        required this.image,
        required this.url,
        required this.approved,
        required this.sponsors,
        required this.latitude,
        required this.longitude,
        required this.address,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.isLike,
        required this.rating,
        required this.academyDetails,
    });

    final String? id;
    final String? userId;
    final String? academyId;
    final String? title;
    final String? noOfTickets;
    final String? ticketsLeft;
    final String? price;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? description;
    final String? type;
    final String? image;
    final String? url;
    final String? approved;
    final dynamic? sponsors;
    final String? latitude;
    final String? longitude;
    final String? address;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? isLike;
    final dynamic rating;
    final List<AcademyDetail> academyDetails;

    factory Tournament.fromJson(Map<String, dynamic> json){ 
        return Tournament(
            id: json["id"],
            userId: json["user_id"],
            academyId: json["academy_id"],
            title: json["title"],
            noOfTickets: json["no_of_tickets"],
            ticketsLeft: json["tickets_left"],
            price: json["price"],
            startDate: DateTime.tryParse(json["start_date"] ?? ""),
            endDate: DateTime.tryParse(json["end_date"] ?? ""),
            description: json["description"],
            type: json["type"],
            image: json["image"],
            url: json["url"],
            approved: json["approved"],
            sponsors: json["sponsors"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            address: json["address"],
            status: json["status"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            isLike: json["is_like"],
            rating: json["rating"],
            academyDetails: json["academy_details"] == null ? [] : List<AcademyDetail>.from(json["academy_details"]!.map((x) => AcademyDetail.fromJson(x))),
        );
    }

}

class AcademyDetail {
    AcademyDetail({
        required this.id,
        required this.userId,
        required this.venueId,
        required this.name,
        required this.address,
        required this.logo,
        required this.latitude,
        required this.longitude,
        required this.description,
        required this.contactNo,
        required this.headCoach,
        required this.sessionTimings,
        required this.weekDays,
        required this.price,
        required this.remarksPrice,
        required this.skillLevel,
        required this.academyJersey,
        required this.capacity,
        required this.remarksCurrentCapacity,
        required this.sessionPlan,
        required this.remarksSessionPlan,
        required this.ageGroupOfStudents,
        required this.remarksStudents,
        required this.equipment,
        required this.remarksOnEquipment,
        required this.floodLights,
        required this.groundSize,
        required this.person,
        required this.coachExperience,
        required this.noOfAssistentCoach,
        required this.assistentCoachName,
        required this.feedbacks,
        required this.amenitiesId,
        required this.sports,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? userId;
    final String? venueId;
    final String? name;
    final String? address;
    final String? logo;
    final String? latitude;
    final String? longitude;
    final String? description;
    final String? contactNo;
    final String? headCoach;
    final String? sessionTimings;
    final String? weekDays;
    final String? price;
    final String? remarksPrice;
    final String? skillLevel;
    final String? academyJersey;
    final String? capacity;
    final String? remarksCurrentCapacity;
    final String? sessionPlan;
    final String? remarksSessionPlan;
    final String? ageGroupOfStudents;
    final String? remarksStudents;
    final String? equipment;
    final String? remarksOnEquipment;
    final String? floodLights;
    final String? groundSize;
    final String? person;
    final String? coachExperience;
    final String? noOfAssistentCoach;
    final String? assistentCoachName;
    final String? feedbacks;
    final String? amenitiesId;
    final String? sports;
    final String? status;
    final String? createdAt;
    final String? updatedAt;

    factory AcademyDetail.fromJson(Map<String, dynamic> json){ 
        return AcademyDetail(
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
            coachExperience: json["coach_experience"],
            noOfAssistentCoach: json["no_of_assistent_coach"],
            assistentCoachName: json["assistent_coach_name"],
            feedbacks: json["feedbacks"],
            amenitiesId: json["amenities_id"],
            sports: json["sports"],
            status: json["status"],
            createdAt: json["created_at"],
            updatedAt: json["updated_at"],
        );
    }

}

class Sponsor {
    Sponsor({
        required this.id,
        required this.name,
        required this.website,
        required this.contact,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? name;
    final String? website;
    final String? contact;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Sponsor.fromJson(Map<String, dynamic> json){ 
        return Sponsor(
            id: json["id"],
            name: json["name"],
            website: json["website"],
            contact: json["contact"],
            status: json["status"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}
