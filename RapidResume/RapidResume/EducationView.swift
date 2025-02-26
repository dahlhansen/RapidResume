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
            ScrollView {
                VStack(spacing: 15) {
                    
                    Text("Education Details")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Institution Name")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Enter Institution Name", text: $institution)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)

                    Text("Degree Name")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Enter Degree Name", text: $degree)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)

                    Text("Location")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Where was it located", text: $location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)

                    Text("When?")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Jan. 2023 -- May. 2026", text: $dates)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)

                    Text("Details?")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Add your first detail bullet?", text: $detail1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)

                    TextField("Add your second detail bullet?", text: $detail2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)

                    TextField("Add your third detail bullet?", text: $detail3)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)

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
                            .background(Color.teal)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    Divider()

                    if !educations.isEmpty {
                        Text("Your Education Entries")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top)

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

                    Spacer()

                    Button(action: {
                        navigateNext = true
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
                        EducationView()
                    }
                    .padding(.bottom)
                }
                .padding()
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
        VStack(alignment: .leading, spacing: 8) {
            Text(education.degree)
                .font(.headline)
                .foregroundColor(.white)
            Text(education.institution)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            Text(education.dates)
                .font(.footnote)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.8), Color.orange.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}
