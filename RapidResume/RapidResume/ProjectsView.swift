import SwiftUI

struct ProjectsView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    
    @State private var projects: [ProjectEntry] = []
    @State private var title = ""
    @State private var techStack = ""
    @State private var dates = ""
    @State private var bullet1 = ""
    @State private var bullet2 = ""
    @State private var bullet3 = ""
    @State private var navigateNext = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.mediumBlue, Color.darkBlue]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    Text("Projects")
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(.electricYellow)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        
                        .font(.custom("Poppins-Bold", size: 48))
                        .padding(.bottom, 5)
                    
                    Text("What have you developed in your spare time?")
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(.electricYellow)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        
                        .font(.custom("Poppins-Bold", size: 16))
                    
                    VStack(spacing: 20) {
                        
                        
                        
                        Spacer()
                        
                        TextField("Project Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Tech Stack", text: $techStack)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Dates (e.g., Sept. 2024 - Dec. 2024)", text: $dates)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("First Highlight", text: $bullet1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Second Highlight", text: $bullet2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Third Highlight", text: $bullet3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        Button(action: {
                            let bulletPoints = [bullet1, bullet2, bullet3].filter { !$0.isEmpty }
                            
                            if !title.isEmpty && !techStack.isEmpty && !dates.isEmpty && !bulletPoints.isEmpty {
                                let project = ProjectEntry(title: title, tech_stack: techStack, dates: dates, bullets: bulletPoints)
                                projects.append(project)
                                
                                title = ""
                                techStack = ""
                                dates = ""
                                bullet1 = ""
                                bullet2 = ""
                                bullet3 = ""
                            }
                        }) {
                            Text("Add Project")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.darkBlue)
                                .frame(maxWidth: 200)
                                .background(Color.paleBlue)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)
                        
                        if !projects.isEmpty {
                            Text("Your Projects")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                                .foregroundColor(.electricYellow)
                            
                            VStack(spacing: 10) {
                                ForEach(projects.indices, id: \.self) { index in
                                    ProjectRow(project: projects[index])
                                        .gesture(DragGesture(minimumDistance: 50)
                                            .onEnded { _ in
                                                withAnimation {
                                                    deleteProject(at: index)
                                                }
                                            }
                                        )
                                        .transition(.slide)
                                }
                            }
                        }
                        
                        Button(action: {
                            vm.resume.projects = projects
                            navigateNext = true
                        }) {
                            Text("Next")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: 200)
                                .background(Color.electricYellow)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .navigationDestination(isPresented: $navigateNext) {
                            ExperienceView()
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.top, 10)
                }
            }
        }
    }
    
    private func deleteProject(at index: Int) {
        projects.remove(at: index)
    }
}


struct ProjectRow: View {
    var project: ProjectEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(project.title)
                .font(.headline)
                .foregroundColor(.darkBlue)
            Text(project.tech_stack)
                .font(.subheadline)
                .foregroundColor(.darkBlue.opacity(0.8))
            Text(project.dates)
                .font(.footnote)
                .foregroundColor(.darkBlue.opacity(0.6))
            Text(project.bullets.joined(separator: "\n• "))
                .font(.subheadline)
                .foregroundColor(.darkBlue.opacity(0.9))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.paleBlue)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}

#Preview {
    ProjectsView()
}
