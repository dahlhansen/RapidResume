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
                Color.customDarkGray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    Image(systemName: "pencil.line")
                        .resizable()
                        .frame(width: 42, height: 43)
                        .foregroundStyle(Color.white)
                    
                        
                    
                    Text("Projects")
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        
                        .font(.custom("SF Pro", size: 36))
                        
                    
                    Text("What have you developed in your spare time?")
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        
                        .font(.custom("Poppins-Bold", size: 16))
                        .padding(.bottom)
                    
                    VStack(spacing: 20) {
                        
                        
                        
                        Spacer()
                        
                        TextField("Project Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)

                        TextField("Tech Stack", text: $techStack)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)

                        TextField("Dates", text: $dates)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)

                        TextField("First Highlight", text: $bullet1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)

                        TextField("Second Highlight", text: $bullet2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)

                        TextField("Third Highlight", text: $bullet3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    .background(Color.customDark)
                    .cornerRadius(25)
                    
                    Spacer()
                    
                    VStack {
                        
                        if !projects.isEmpty {
                            Text("Your Added Projects")
                                .font(.custom("SF Pro", size: 20))
                                .fontWeight(.regular)
                                .padding(.top)
                                .foregroundColor(.white)
                            
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
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.customDark)
                    .cornerRadius(25)
                    
                    
                    
                    VStack {
                        
                        HStack (spacing: 20) {
                            
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
                                    .frame(maxWidth: 180)
                                    .background(Color.customBlack)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                            }
                            .padding(.bottom, 20)
                            
                            
                            
                            Button(action: {
                                vm.resume.projects = projects
                                navigateNext = true
                            }) {
                                Text("Next")
                                    .padding()
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: 180)
                                    .background(Color.customLightBlue)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                            }
                            .navigationDestination(isPresented: $navigateNext) {
                                ExperienceView()
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .padding(.top, 25)
                }.frame(width: 375)
                
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
        VStack {
            Text(project.title)
                .font(.custom("SF Pro", size: 16))
                .foregroundColor(.white)
                
        }
        .frame(width: 330, height: 35)
        .background(Color.customGray)
        .cornerRadius(5)
        .padding()
    }
}

#Preview {
    ProjectsView()
}
