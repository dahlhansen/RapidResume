//
//  FinalizeResumeView.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 27/02/2025.
//

import SwiftUI

struct FinalizeResumeView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    
    let resume = Resume(
        name: "w",
        phone: "w",
        email: "w",
        linkedin: "w",
        github: "w",
        education: [
            EducationEntry(institution: "w", location: "w", degree: "w", dates: "w", details: ["w", "w"])
        ],
        skills: [
            SkillEntry(category: "w", entries: ["w", "w", "w", "w"])
        ],
        projects: [
            ProjectEntry(title: "w", tech_stack: "w", dates: "w", bullets: ["w", "w", "w", "w"])
        ],
        experiences: [
            ExperienceEntry(role: "w", dates: "w", company: "w", location: "w", details: ["w", "w", "w", "w"])
        ],
        activities: [
            ActivityEntry(title: "w", dates: "w", organization: "w", location: "w", details: ["w", "w", "w", "w"])
        ]
    )

    
    var body: some View {
        
        Button("Create Resume"){
            vm.submitResume(resume: vm.resume)
        }
    }
}

#Preview {
    FinalizeResumeView()
}
