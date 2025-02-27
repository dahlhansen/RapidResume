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
            ScrollView {
                VStack(spacing: 15) {
                    
                    Text("Skills")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Category")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Enter Skill Category (e.g., Frameworks)", text: $category)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Skills")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Group {
                        TextField("Skill 1", text: $entry1)
                        TextField("Skill 2", text: $entry2)
                        TextField("Skill 3", text: $entry3)
                        TextField("Skill 4", text: $entry4)
                        TextField("Skill 5", text: $entry5)
                        TextField("Skill 6", text: $entry6)
                        TextField("Skill 7", text: $entry7)
                        TextField("Skill 8", text: $entry8)
                        TextField("Skill 9", text: $entry9)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(4)
                    .shadow(radius: 3)

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
                            .foregroundColor(.white)
                            .frame(maxWidth: 200)
                            .background(Color.teal)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    Divider()

                    
                    if !skills.isEmpty {
                        Text("Your Skills")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top)

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

                    Spacer()

                    Button(action: {
                        vm.resume.skills = skills
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
                        ProjectsView()
                    }
                    .padding(.bottom)
                }
                .padding()
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
                .foregroundColor(.white)
            Text(skill.entries.joined(separator: ", "))
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.8), Color.orange.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}
