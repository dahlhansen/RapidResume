//
//  Resume.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 26/02/2025.
//

import Foundation

struct Resume: Codable {
    let name: String
    let phone: String
    let email: String
    let linkedin: String
    let github: String
    let education: [EducationEntry]
    let skills: [SkillEntry]
    let projects: [ProjectEntry]
    let experiences: [ExperienceEntry]
    let activities: [ActivityEntry]
}

struct EducationEntry: Codable {
    let institution: String
    let location: String
    let degree: String
    let dates: String
    let details: [String]
}

struct SkillEntry: Codable {
    let category: String
    let entries: [String]
}

struct ProjectEntry: Codable {
    let title: String
    let tech_stack: String
    let dates: String
    let bullets: [String]
}

struct ExperienceEntry: Codable {
    let role: String
    let dates: String
    let company: String
    let location: String
    let details: [String]
}

struct ActivityEntry: Codable {
    let title: String
    let dates: String
    let organization: String
    let location: String
    let details: [String]
}




