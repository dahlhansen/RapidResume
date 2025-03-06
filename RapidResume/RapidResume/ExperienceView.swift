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
                Color.customDarkGray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    Image(systemName: "briefcase.fill")
                        .resizable()
                        .frame(width: 42, height: 43)
                        .foregroundStyle(Color.white)
                    
                    Text("Work Experience")
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .font(.custom("SF Pro", size: 36))
                        .padding(.bottom, 5)
                    
                    Text("What does your career look like?")
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .font(.custom("Poppins-Bold", size: 16))
                        .padding(.bottom, 10)
                    
                    VStack(spacing: 20) {
                    
                        Spacer()
                        
                        TextField("Job Title / Role", text: $role)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Company Name", text: $company)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Location", text: $location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Dates", text: $dates)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("First Responsibility", text: $detail1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Second Responsibility", text: $detail2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Third Responsibility", text: $detail3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    .background(Color.customDark)
                    .cornerRadius(25)
                    
                    Spacer()
                    
                    VStack {
                        if !experiences.isEmpty {
                            Text("Your Work Experience")
                                .font(.custom("SF Pro", size: 20))
                                .fontWeight(.regular)
                                .padding(.top)
                                .foregroundColor(.white)
                            
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
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.customDark)
                    .cornerRadius(25)
                    
                    VStack {
                        HStack(spacing: 20) {
                            
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
                                    .frame(maxWidth: 180)
                                    .background(Color.customBlack)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                            }
                            .padding(.bottom, 20)
                            
                            Button(action: {
                                vm.resume.experiences = experiences
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
                                ActivitiesView()
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .padding(.top, 25)
                }
                .frame(width: 375)
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
        VStack {
            Text(experience.role)
                .font(.custom("SF Pro", size: 16))
                .foregroundColor(.white)
        }
        .frame(width: 300, height: 35)
        .background(Color.customGray)
        .cornerRadius(5)
        .padding()
    }
}

#Preview {
    ExperienceView()
}
