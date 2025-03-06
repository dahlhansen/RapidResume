import SwiftUI

struct ActivitiesView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    
    @State private var activities: [ActivityEntry] = []
    @State private var title = ""
    @State private var organization = ""
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
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 42, height: 43)
                        .foregroundStyle(Color.white)
                    
                    Text("Extracurriculars")
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .font(.custom("SF Pro", size: 36))
                        .padding(.bottom, 5)
                    
                    Text("Activities outside of school?")
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .font(.custom("Poppins-Bold", size: 16))
                        .padding(.bottom, 10)
                    
                    VStack(spacing: 20) {
                        
                        Spacer()
                        
                        TextField("Activity Title / Role", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)

                        TextField("Organization", text: $organization)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)

                        TextField("Location", text: $location)
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

                        TextField("First Responsibility", text: $detail1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)

                        TextField("Second Responsibility", text: $detail2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)

                        TextField("Third Responsibility", text: $detail3)
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
                        if !activities.isEmpty {
                            Text("Your Added Activities")
                                .font(.custom("SF Pro", size: 20))
                                .fontWeight(.regular)
                                .padding(.top)
                                .foregroundColor(.white)
                            
                            VStack(spacing: 10) {
                                ForEach(activities.indices, id: \.self) { index in
                                    ActivityRow(activity: activities[index])
                                        .gesture(DragGesture(minimumDistance: 50)
                                            .onEnded { _ in
                                                withAnimation {
                                                    deleteActivity(at: index)
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
                                
                                if !title.isEmpty && !organization.isEmpty && !location.isEmpty && !dates.isEmpty && !details.isEmpty {
                                    let activity = ActivityEntry(title: title, dates: dates, organization: organization, location: location, details: details)
                                    activities.append(activity)
                                    
                                    title = ""
                                    organization = ""
                                    location = ""
                                    dates = ""
                                    detail1 = ""
                                    detail2 = ""
                                    detail3 = ""
                                }
                            }) {
                                Text("Add Activity")
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
                                vm.resume.activities = activities
                                navigateNext = true
                            }) {
                                Text("Finish")
                                    .padding()
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: 180)
                                    .background(Color.customLightBlue)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                            }
                            .navigationDestination(isPresented: $navigateNext) {
                                FinalizeResumeView()
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
    
    private func deleteActivity(at index: Int) {
        activities.remove(at: index)
    }
}

struct ActivityRow: View {
    var activity: ActivityEntry

    var body: some View {
        VStack {
            Text(activity.title)
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
    ActivitiesView()
}
