import SwiftUI

struct FinalizeResumeView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    @State private var navigateNext = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customDarkGray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 15) {
                        
                        Image(systemName: "doc.plaintext.fill")
                            .resizable()
                            .frame(width: 42, height: 43)
                            .foregroundStyle(Color.white)
                        
                        Text("Finalize Your Resume")
                            .fontWeight(.heavy)
                            .fontDesign(.rounded)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                            .font(.custom("SF Pro", size: 36))
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        ResumeSection(title: "Personal Info") {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Name: \(vm.resume.name)")
                                Text("Phone: \(vm.resume.phone)")
                                Text("Email: \(vm.resume.email)")
                                Text("LinkedIn: \(vm.resume.linkedin)")
                                Text("GitHub: \(vm.resume.github)")
                            }
                            .frame(width: 300, alignment: .leading)
                            .foregroundStyle(Color.white)
                            
                        }
                        
                        VStack {
                            if !vm.resume.education.isEmpty {
                                ResumeSection(title: "Education") {
                                    ForEach(vm.resume.education, id: \.institution) { edu in
                                        ResumeRow(title: "\(edu.degree) at \(edu.institution)", subtitle: "\(edu.dates) - \(edu.location)", details: edu.details)
                                    }
                                }
                            }
                        }
                        .frame(width: 300, alignment: .leading)
                        .foregroundStyle(Color.white)
                        
                        VStack {
                            if !vm.resume.experiences.isEmpty {
                                ResumeSection(title: "Work Experience") {
                                    ForEach(vm.resume.experiences, id: \.company) { exp in
                                        ResumeRow(title: "\(exp.role) at \(exp.company)", subtitle: "\(exp.dates) - \(exp.location)", details: exp.details)
                                    }
                                }
                            }
                        }
                        .frame(width: 300, alignment: .leading)
                        .foregroundStyle(Color.white)
                        
                        VStack {
                            if !vm.resume.projects.isEmpty {
                                ResumeSection(title: "Projects") {
                                    ForEach(vm.resume.projects, id: \.title) { project in
                                        ResumeRow(title: project.title, subtitle: "Tech Stack: \(project.tech_stack) | \(project.dates)", details: project.bullets)
                                    }
                                }
                            }
                        }
                        .frame(width: 300, alignment: .leading)
                        .foregroundStyle(Color.white)
                        
                        VStack {
                            if !vm.resume.skills.isEmpty {
                                ResumeSection(title: "Skills") {
                                    ForEach(vm.resume.skills, id: \.category) { skill in
                                        ResumeRow(title: skill.category, subtitle: "", details: skill.entries)
                                    }
                                }
                            }
                        }
                        .frame(width: 300, alignment: .leading)
                        .foregroundStyle(Color.white)
                        
                        
                        VStack {
                            if !vm.resume.activities.isEmpty {
                                ResumeSection(title: "Extracurricular Activities") {
                                    ForEach(vm.resume.activities, id: \.title) { activity in
                                        ResumeRow(title: "\(activity.title) at \(activity.organization)", subtitle: "\(activity.dates) - \(activity.location)", details: activity.details)
                                    }
                                }
                            }
                        }
                        .frame(width: 300, alignment: .leading)
                        .foregroundStyle(Color.white)
                        
                        
                        
                        Button(action: {
                            vm.submitResume(resume: vm.resume)
                            navigateNext = true
                        }) {
                            Text("Create Resume")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .background(Color.customLightBlue)
                                .cornerRadius(25)
                                .shadow(radius: 5)
                        }
                        .navigationDestination(isPresented: $navigateNext) {
                            ViewResume()
                        }
                        
                    }
                    .padding(.top, 10)
                }
                .frame(width: 375)
            }
        }
    }
}

struct ResumeSection<Content: View>: View {
    var title: String
    var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.electricYellow)
            
            content()
        }
        .padding()
        .background(Color.customDark)
        .cornerRadius(25)
        .shadow(radius: 3)
        .padding(.horizontal, 40)
    }
}

struct ResumeRow: View {
    var title: String
    var subtitle: String
    var details: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.custom("SF Pro", size: 16))
                .foregroundColor(.white)
            if !subtitle.isEmpty {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            if !details.isEmpty {
                Text(details.joined(separator: "\n• "))
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
            }
        }
        .frame(width: 300, height: details.isEmpty ? 35 : nil)
        .padding()
        .background(Color.customGray)
        .cornerRadius(5)
    }
}

#Preview {
    FinalizeResumeView()
        .environmentObject(ResumeViewModel())
}
