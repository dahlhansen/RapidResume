import SwiftUI

struct SkillView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    
    @State private var skills: [SkillEntry] = []
    @State private var category = ""
    @State private var skillEntries: [String] = Array(repeating: "", count: 9)
    @State private var navigateNext = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color.customDarkGray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        Image(systemName: "hammer.fill")
                            .resizable()
                            .frame(width: 42, height: 43)
                            .foregroundStyle(Color.white)
                        
                        Text("Skills")
                            .fontWeight(.heavy)
                            .fontDesign(.rounded)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                            .font(.custom("SF Pro", size: 36))
                            .padding(.bottom, 5)
                        
                        Text("What makes you stand out?")
                            .fontDesign(.rounded)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                            .font(.custom("SF Pro", size: 16))
                        
                        
                        
                        VStack(spacing: 20) {
                            TextField("Skill Category (e.g., Frameworks)", text: $category)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .multilineTextAlignment(.center)
                            
                            Divider()
                                .frame(height: 2)
                                .background(Color.electricYellow)
                                .padding(.horizontal, 40)
                            
                            ForEach(0..<9, id: \.self) { index in
                                TextField("Skill \(index + 1)", text: $skillEntries[index])
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        .background(Color.customDark)
                        .cornerRadius(25)
                        
                        
                        
                        if !skills.isEmpty {
                            Text("Your Skills")
                                .font(.custom("SF Pro", size: 20))
                                .fontWeight(.regular)
                                .padding(.top)
                                .foregroundColor(.white)
                            
                            VStack(spacing: 10) {
                                ForEach(skills.indices, id: \.self) { index in
                                    SkillRow(skill: skills[index])
                                        .gesture(DragGesture(minimumDistance: 50)
                                            .onEnded { _ in
                                                withAnimation {
                                                    deleteSkill(at: index)
                                                }
                                            }
                                        )
                                        .transition(.slide)
                                }
                            }
                        }
                        
                        HStack {
                            
                            Button(action: {
                                let filteredSkills = skillEntries.filter { !$0.isEmpty }
                                
                                if !category.isEmpty && !filteredSkills.isEmpty {
                                    let skillEntry = SkillEntry(category: category, entries: filteredSkills)
                                    skills.append(skillEntry)
                                    
                                    category = ""
                                    skillEntries = Array(repeating: "", count: 9)
                                }
                            }) {
                                Text("Add Skill")
                                    .padding()
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: 200)
                                    .background(Color.customBlack)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                            }
                            .padding(.bottom, 10)
                            
                            Button(action: {
                                vm.resume.skills = skills
                                navigateNext = true
                            }) {
                                Text("Next")
                                    .padding()
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: 200)
                                    .background(Color.customLightBlue)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                            }
                            .navigationDestination(isPresented: $navigateNext) {
                                ProjectsView()
                            }
                            .padding(.bottom, 10)
                            
                            
                            
                            
                        }
                        .padding(.top, 10)
                    }
                }
                .frame(width: 375)
            }
        }
    }
    
    private func deleteSkill(at index: Int) {
        skills.remove(at: index)
    }
}

struct SkillRow: View {
    var skill: SkillEntry

    var body: some View {
        VStack {
            Text(skill.category)
                .font(.custom("SF Pro", size: 16))
                .foregroundColor(.white)
            Text(skill.entries.joined(separator: ", "))
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(width: 300, height: 35)
        .padding()
        .background(Color.customGray)
        .cornerRadius(5)
    }
}

#Preview {
    SkillView()
        .environmentObject(ResumeViewModel())
}
