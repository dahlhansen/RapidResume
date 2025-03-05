import SwiftUI

struct SkillView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    
    @State private var skills: [SkillEntry] = []
    @State private var category = ""
    @State private var entry1 = ""
    @State private var entry2 = ""
    @State private var entry3 = ""
    @State private var entry4 = ""
    @State private var entry5 = ""
    @State private var entry6 = ""
    @State private var entry7 = ""
    @State private var entry8 = ""
    @State private var entry9 = ""
    @State private var navigateNext = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.mediumBlue, Color.darkBlue]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    Text("Skills")
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(.electricYellow)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        
                        .font(.custom("Poppins-Bold", size: 48))
                        .padding(.bottom, 5)
                    
                    Text("What makes you stand out?")
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(.electricYellow)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        
                        .font(.custom("Poppins-Bold", size: 16))
                        .padding(.bottom, 5)
                    
                    VStack(spacing: 15) {
                        
                        
                        
                        Spacer()
                        
                        TextField("Skill Category (e.g., Frameworks)", text: $category)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color.paleBlue)
                            .padding(.horizontal, 40)
                        
                        TextField("Skill 1", text: $entry1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Skill 2", text: $entry2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Skill 3", text: $entry3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Skill 4", text: $entry4)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Skill 5", text: $entry5)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Skill 6", text: $entry6)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Skill 7", text: $entry7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Skill 8", text: $entry8)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Skill 9", text: $entry9)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        Button(action: {
                            let skillEntries = [entry1, entry2, entry3, entry4, entry5, entry6, entry7, entry8, entry9].filter { !$0.isEmpty }
                            
                            if !category.isEmpty && !skillEntries.isEmpty {
                                let skillEntry = SkillEntry(category: category, entries: skillEntries)
                                skills.append(skillEntry)
                                
                                category = ""
                                entry1 = ""
                                entry2 = ""
                                entry3 = ""
                                entry4 = ""
                                entry5 = ""
                                entry6 = ""
                                entry7 = ""
                                entry8 = ""
                                entry9 = ""
                            }
                        }) {
                            Text("Save Skill Category")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.darkBlue)
                                .frame(maxWidth: 200)
                                .background(Color.paleBlue)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)
                        
                        Divider()
                            .padding(.vertical, 10)
                        
                        if !skills.isEmpty {
                            Text("Your Skills")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                                .foregroundColor(.electricYellow)
                            
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
                        
                        Divider()
                        
                        Button(action: {
                            vm.resume.skills = skills
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
                            ProjectsView()
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.top, 10)
                }
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
        VStack(alignment: .leading, spacing: 8) {
            Text(skill.category)
                .font(.headline)
                .foregroundColor(.darkBlue)
            Text(skill.entries.joined(separator: ", "))
                .font(.subheadline)
                .foregroundColor(.darkBlue.opacity(0.8))
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
    SkillView()
}
