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
            ScrollView {
                VStack(spacing: 15) {
                    
                    Text("Work Experience")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Job Title / Role")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Enter Role (e.g., Software Developer)", text: $role)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Company Name")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Company Name (e.g., Google, RBC)", text: $company)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Location")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Enter Location (e.g., Toronto, ON)", text: $location)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Dates")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Feb. 2024 -- Present", text: $dates)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Job Responsibilities")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("First Responsibility", text: $detail1)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    TextField("Second Responsibility", text: $detail2)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    TextField("Third Responsibility", text: $detail3)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

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
                            .background(Color.teal)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    Divider()

                    /// **Experience List (Inside ScrollView)**
                    if !experiences.isEmpty {
                        Text("Your Work Experience")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top)

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
                        ActivitiesView()
                    }
                    .padding(.bottom)
                }
                .padding()
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
                .foregroundColor(.white)
            Text(experience.company)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            Text(experience.dates)
                .font(.footnote)
                .foregroundColor(.white.opacity(0.6))
            Text(experience.details.joined(separator: "\n• "))
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
