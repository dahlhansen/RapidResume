//
//  FinalizeResumeView.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 27/02/2025.
//

import SwiftUI

struct FinalizeResumeView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.paleBlue, Color.darkBlue]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 15) {
                        
                        Text("Finalize Your Resume")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Personal Info")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.electricYellow)
                            
                            Text("Name: \(vm.resume.name)")
                            Text("Phone: \(vm.resume.phone)")
                            Text("Email: \(vm.resume.email)")
                            Text("LinkedIn: \(vm.resume.linkedin)")
                            Text("GitHub: \(vm.resume.github)")
                        }
                        .padding()
                        .background(Color.paleBlue.opacity(0.5))
                        .cornerRadius(12)
                        .shadow(radius: 3)
                        .padding(.horizontal, 40)
                        
                        if !vm.resume.education.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Education")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.electricYellow)
                                
                                ForEach(vm.resume.education, id: \.institution) { edu in
                                    VStack(alignment: .leading) {
                                        Text("\(edu.degree) at \(edu.institution)")
                                            .font(.headline)
                                        Text("\(edu.dates) - \(edu.location)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text(edu.details.joined(separator: "\n• "))
                                    }
                                    .padding(.top, 5)
                                }
                            }
                            .padding()
                            .background(Color.paleBlue.opacity(0.5))
                            .cornerRadius(12)
                            .shadow(radius: 3)
                            .padding(.horizontal, 40)
                        }
                        
                        if !vm.resume.experiences.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Work Experience")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.electricYellow)
                                
                                ForEach(vm.resume.experiences, id: \.company) { exp in
                                    VStack(alignment: .leading) {
                                        Text("\(exp.role) at \(exp.company)")
                                            .font(.headline)
                                        Text("\(exp.dates) - \(exp.location)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text(exp.details.joined(separator: "\n• "))
                                    }
                                    .padding(.top, 5)
                                }
                            }
                            .padding()
                            .background(Color.paleBlue.opacity(0.5))
                            .cornerRadius(12)
                            .shadow(radius: 3)
                            .padding(.horizontal, 40)
                        }
                        
                        if !vm.resume.projects.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Projects")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.electricYellow)
                                
                                ForEach(vm.resume.projects, id: \.title) { project in
                                    VStack(alignment: .leading) {
                                        Text(project.title)
                                            .font(.headline)
                                        Text("Tech Stack: \(project.tech_stack)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text("\(project.dates)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text(project.bullets.joined(separator: "\n• "))
                                    }
                                    .padding(.top, 5)
                                }
                            }
                            .padding()
                            .background(Color.paleBlue.opacity(0.5))
                            .cornerRadius(12)
                            .shadow(radius: 3)
                            .padding(.horizontal, 40)
                        }
                        
                        
                        if !vm.resume.skills.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Skills")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.electricYellow)
                                
                                ForEach(vm.resume.skills, id: \.category) { skill in
                                    VStack(alignment: .leading) {
                                        Text(skill.category)
                                            .font(.headline)
                                        Text(skill.entries.joined(separator: ", "))
                                    }
                                    .padding(.top, 5)
                                }
                            }
                            .padding()
                            .background(Color.paleBlue.opacity(0.5))
                            .cornerRadius(12)
                            .shadow(radius: 3)
                            .padding(.horizontal, 40)
                        }
                        
                        if !vm.resume.activities.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Extracurricular Activities")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.electricYellow)
                                
                                ForEach(vm.resume.activities, id: \.title) { activity in
                                    VStack(alignment: .leading) {
                                        Text("\(activity.title) at \(activity.organization)")
                                            .font(.headline)
                                        Text("\(activity.dates) - \(activity.location)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text(activity.details.joined(separator: "\n• "))
                                    }
                                    .padding(.top, 5)
                                }
                            }
                            .padding()
                            .background(Color.paleBlue.opacity(0.5))
                            .cornerRadius(12)
                            .shadow(radius: 3)
                            .padding(.horizontal, 40)
                        }
                        
                        Button(action: {
                            vm.submitResume(resume: vm.resume)
                        }) {
                            Text("Create Resume")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: 200)
                                .background(Color.electricYellow)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.top, 10)
                }
            }
        }
    }
}
