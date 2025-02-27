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
            ScrollView {
                VStack(spacing: 15) {
                    
                    Text("Extracurricular Activities")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Activity Title / Role")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Enter Role (e.g., President, Volunteer)", text: $title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Organization")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Enter Organization (e.g., Sheridan Golf Club)", text: $organization)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Location")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Enter Location (e.g., Oakville, ON)", text: $location)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Dates")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Oct. 2024 -- Present", text: $dates)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    Text("Responsibilities / Achievements")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("First Detail", text: $detail1)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    TextField("Second Detail", text: $detail2)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

                    TextField("Third Detail", text: $detail3)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 3)

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
                            .background(Color.teal)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    Divider()

                    /// **Activities List (Inside ScrollView)**
                    if !activities.isEmpty {
                        Text("Your Activities")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top)

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

                    Spacer()

                    Button(action: {
                        vm.resume.activities = activities
                        navigateNext = true
                        print(vm.resume)
                    }) {
                        Text("Finish")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: 200)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .navigationDestination(isPresented: $navigateNext) {
                        
                    }
                    .padding(.bottom)
                }
                .padding()
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
                .foregroundColor(.white)
            Text(activity.organization)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            Text(activity.dates)
                .font(.footnote)
                .foregroundColor(.white.opacity(0.6))
            Text(activity.details.joined(separator: "\n• "))
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
