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
                Color.customDarkGray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    Image(systemName: "graduationcap.fill")
                        .resizable()
                        .frame(width: 42, height: 43)
                        .foregroundStyle(Color.white)
                    
                    Text("Education")
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .font(.custom("SF Pro", size: 36))
                        .padding(.bottom, 5)
                    
                    Text("Where did you study?")
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .font(.custom("Poppins-Bold", size: 16))
                        .padding(.bottom, 10)
                    
                    VStack(spacing: 20) {
                        
                        Spacer()
                        
                        TextField("Institution Name", text: $institution)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Degree Name", text: $degree)
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
                        
                        TextField("First Detail", text: $detail1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Second Detail", text: $detail2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Third Detail", text: $detail3)
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
                        if !educations.isEmpty {
                            Text("Your Added Education Entries")
                                .font(.custom("SF Pro", size: 20))
                                .fontWeight(.regular)
                                .padding(.top)
                                .foregroundColor(.white)
                            
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
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.customDark)
                    .cornerRadius(25)
                    
                    VStack {
                        HStack(spacing: 20) {
                            
                            Button(action: {
                                detailsList = [detail1, detail2, detail3].filter { !$0.isEmpty }
                                
                                if !institution.isEmpty && !location.isEmpty && !degree.isEmpty && !dates.isEmpty && !detailsList.isEmpty {
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
                                }
                            }) {
                                Text("Add Degree")
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
                                vm.resume.education = educations
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
                                SkillView()
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
    
    private func deleteEducation(at index: Int) {
        educations.remove(at: index)
    }
}

struct EducationRow: View {
    var education: EducationEntry

    var body: some View {
        VStack {
            Text(education.degree)
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
    EducationView()
}
