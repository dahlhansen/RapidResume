import SwiftUI

struct EducationView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    
    @State private var educations: [EducationEntry] = []
    @State private var institution = ""
    @State private var location = ""
    @State private var degree = ""
    @State private var dates = ""
    @State private var detailsList: [String] = []
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
                        
                        Text("Education Details")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        TextField("Institution Name", text: $institution)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Degree Name", text: $degree)
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

                        TextField("When? (e.g., Jan. 2023 - May. 2026)", text: $dates)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        TextField("First Detail", text: $detail1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Second Detail", text: $detail2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Third Detail", text: $detail3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        Button(action: {
                            detailsList = [detail1, detail2, detail3].filter { !$0.isEmpty }
                            
                            let education = EducationEntry(institution: institution, location: location, degree: degree, dates: dates, details: detailsList)
                            
                            educations.append(education)
                            
                            institution = ""
                            location = ""
                            degree = ""
                            dates = ""
                            detailsList = []
                            detail1 = ""
                            detail2 = ""
                            detail3 = ""
                        }) {
                            Text("Add Degree")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .background(Color.black)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)
                        
                        Divider()
                            .padding(.vertical, 10)
                        
                        if !educations.isEmpty {
                            Text("Your Education Entries")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                                .foregroundColor(.electricYellow)
                            
                            VStack(spacing: 10) {
                                ForEach(educations.indices, id: \.self) { index in
                                    EducationRow(education: educations[index])
                                        .gesture(DragGesture(minimumDistance: 50)
                                            .onEnded { _ in
                                                withAnimation {
                                                    deleteEducation(at: index)
                                                }
                                            }
                                        )
                                        .transition(.slide)
                                }
                            }
                        }
                        
                        Divider()
                        
                        Button(action: {
                            vm.resume.education = educations
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
                            SkillView()
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.top, 10)
                }
            }
        }
    }
    
    private func deleteEducation(at index: Int) {
        educations.remove(at: index)
    }
}

// **Education Row View**
struct EducationRow: View {
    var education: EducationEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(education.degree)
                .font(.headline)
                .foregroundColor(.darkBlue)
            Text(education.institution)
                .font(.subheadline)
                .foregroundColor(.darkBlue.opacity(0.8))
            Text(education.dates)
                .font(.footnote)
                .foregroundColor(.darkBlue.opacity(0.6))
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
    EducationView()
}
