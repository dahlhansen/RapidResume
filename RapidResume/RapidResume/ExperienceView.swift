import SwiftUI

struct ExperienceView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    
    @State private var experiences: [ExperienceEntry] = []
    @State private var role = ""
    @State private var company = ""
    @State private var location = ""
    @State private var dates = ""
    @State private var detail1 = ""
    @State private var detail2 = ""
    @State private var detail3 = ""
    @State private var navigateNext = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.paleBlue, Color.darkBlue]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 15) {
                        
                        Text("Work Experience")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        TextField("Job Title / Role", text: $role)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Company Name", text: $company)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Location", text: $location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Dates (e.g., Feb. 2024 - Present)", text: $dates)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("First Responsibility", text: $detail1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Second Responsibility", text: $detail2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Third Responsibility", text: $detail3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        Button(action: {
                            let details = [detail1, detail2, detail3].filter { !$0.isEmpty }
                            
                            if !role.isEmpty && !company.isEmpty && !location.isEmpty && !dates.isEmpty && !details.isEmpty {
                                let experience = ExperienceEntry(role: role, dates: dates, company: company, location: location, details: details)
                                experiences.append(experience)
                                
                                role = ""
                                company = ""
                                location = ""
                                dates = ""
                                detail1 = ""
                                detail2 = ""
                                detail3 = ""
                            }
                        }) {
                            Text("Add Experience")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .background(Color.black)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)
                        
                        if !experiences.isEmpty {
                            Text("Your Work Experience")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                                .foregroundColor(.electricYellow)
                            
                            VStack(spacing: 10) {
                                ForEach(experiences.indices, id: \.self) { index in
                                    ExperienceRow(experience: experiences[index])
                                        .gesture(DragGesture(minimumDistance: 50)
                                            .onEnded { _ in
                                                withAnimation {
                                                    deleteExperience(at: index)
                                                }
                                            }
                                        )
                                        .transition(.slide)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            vm.resume.experiences = experiences
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
                            ActivitiesView()
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.top, 10)
                }
            }
        }
    }
    
    private func deleteExperience(at index: Int) {
        experiences.remove(at: index)
    }
}

struct ExperienceRow: View {
    var experience: ExperienceEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(experience.role)
                .font(.headline)
                .foregroundColor(.darkBlue)
            Text(experience.company)
                .font(.subheadline)
                .foregroundColor(.darkBlue.opacity(0.8))
            Text(experience.dates)
                .font(.footnote)
                .foregroundColor(.darkBlue.opacity(0.6))
            Text(experience.details.joined(separator: "\n• "))
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
    ExperienceView()
}
