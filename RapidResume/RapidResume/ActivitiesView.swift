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
                LinearGradient(gradient: Gradient(colors: [Color.paleBlue, Color.darkBlue]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 15) {
                        
                        Text("Extracurricular Activities")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        TextField("Activity Title / Role", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Organization", text: $organization)
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

                        TextField("Dates (e.g., Oct. 2024 - Present)", text: $dates)
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
                                .frame(maxWidth: 200)
                                .background(Color.black)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)
                        
                        if !activities.isEmpty {
                            Text("Your Activities")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                                .foregroundColor(.electricYellow)
                            
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
                        
                        Button(action: {
                            vm.resume.activities = activities
                            print(vm.resume)
                            navigateNext = true
                        }) {
                            Text("Finish")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: 200)
                                .background(Color.electricYellow)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .navigationDestination(isPresented: $navigateNext) {
                            FinalizeResumeView()
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.top, 10)
                }
            }
        }
    }
    
    private func deleteActivity(at index: Int) {
        activities.remove(at: index)
    }
}

/// **Styled Activity List Row**
struct ActivityRow: View {
    var activity: ActivityEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(activity.title)
                .font(.headline)
                .foregroundColor(.darkBlue)
            Text(activity.organization)
                .font(.subheadline)
                .foregroundColor(.darkBlue.opacity(0.8))
            Text(activity.dates)
                .font(.footnote)
                .foregroundColor(.darkBlue.opacity(0.6))
            Text(activity.details.joined(separator: "\n• "))
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
    ActivitiesView()
}
