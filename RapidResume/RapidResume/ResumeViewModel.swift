//
//  ResumeViewModel.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 26/02/2025.
//

import Foundation


class ResumeViewModel: ObservableObject {
    @Published var resume = Resume(
        name: "",
        phone: "",
        email: "",
        linkedin: "",
        github: "",
        education: [],
        skills: [],
        projects: [],
        experiences: [],
        activities: []
    )
}
