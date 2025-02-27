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
            ScrollView {
                VStack(spacing: 15) {
                    
                    Text("Projects")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Project Title")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Enter Project Title", text: $title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Tech Stack")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Technologies Used (e.g., Swift, Firebase, API)", text: $techStack)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Dates")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Sept. 2024 -- Dec. 2024", text: $dates)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Project Highlights")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("First Bullet Point", text: $bullet1)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    TextField("Second Bullet Point", text: $bullet2)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    TextField("Third Bullet Point", text: $bullet3)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

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
                            .foregroundColor(.white)
                            .frame(maxWidth: 200)
                            .background(Color.teal)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    Divider()

                    /// **Projects List (Inside ScrollView)**
                    if !projects.isEmpty {
                        Text("Your Projects")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top)

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

                    Spacer()

                    Button(action: {
                        vm.resume.projects = projects
                        navigateNext = true
                        print(vm.resume)
                    }) {
                        Text("Next")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: 200)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .navigationDestination(isPresented: $navigateNext) {
                        ExperienceView()
                    }
                    .padding(.bottom)
                }
                .padding()
            }
        }
    }
    
    private func deleteProject(at index: Int) {
        projects.remove(at: index)
    }
}

/// **Styled Project List Row**
struct ProjectRow: View {
    var project: ProjectEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(project.title)
                .font(.headline)
                .foregroundColor(.white)
            Text(project.tech_stack)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            Text(project.dates)
                .font(.footnote)
                .foregroundColor(.white.opacity(0.6))
            Text(project.bullets.joined(separator: "\n• "))
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.8), Color.orange.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}
