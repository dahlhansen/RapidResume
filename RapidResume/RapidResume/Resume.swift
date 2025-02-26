//
//  Resume.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 26/02/2025.
//

import Foundation

struct Resume: Codable {
    var name: String
    var phone: String
    var email: String
    var linkedin: String
    var github: String
    var education: [EducationEntry]
    var skills: [SkillEntry]
    var projects: [ProjectEntry]
    var experiences: [ExperienceEntry]
    var activities: [ActivityEntry]
}

struct EducationEntry: Codable {
    var institution: String
    var location: String
    var degree: String
    var dates: String
    var details: [String]
}

struct SkillEntry: Codable {
    var category: String
    var entries: [String]
}

struct ProjectEntry: Codable {
    var title: String
    var tech_stack: String
    var dates: String
    var bullets: [String]
}

struct ExperienceEntry: Codable {
    var role: String
    var dates: String
    var company: String
    var location: String
    var details: [String]
}

struct ActivityEntry: Codable {
    var title: String
    var dates: String
    var organization: String
    var location: String
    var details: [String]
}



