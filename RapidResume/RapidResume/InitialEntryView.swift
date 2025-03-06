import SwiftUI

struct InitialEntryView: View {
    
    @EnvironmentObject var vm: ResumeViewModel
    
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var linkedIn = ""
    @State private var gitHub = ""
    
    @State private var navigateNext = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color.customDarkGray
                    .edgesIgnoringSafeArea(.all)
                
                
                
                ScrollView {
                    VStack {
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 42, height: 43)
                            .foregroundStyle(Color.white)
                            .padding(.top, 50)
                        
                        
                        Text("Personal Info")
                            .fontWeight(.heavy)
                            .fontDesign(.rounded)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                            .font(.custom("SF Pro", size: 36))
                            .padding(.bottom, 1)
                        
                        Text("Let's get the personal info out of the way!")
                            .fontDesign(.rounded)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                            .font(.custom("SF Pro", size: 16))
                            .padding(.bottom, 50)
                        
                        Spacer()
                        
                        VStack(spacing: 20) {
                            TextField("Enter Name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .multilineTextAlignment(.center)
                            
                            TextField("Enter Phone Number", text: $phoneNumber)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .multilineTextAlignment(.center)
                            
                            TextField("Enter Desired Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .multilineTextAlignment(.center)
                            
                            TextField("linkedin.com/in/", text: $linkedIn)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .multilineTextAlignment(.center)
                            
                            TextField("github.com/", text: $gitHub)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        .background(Color.customDark)
                        .cornerRadius(25)
                        
                        VStack {
                            
                            Button(action: {
                                vm.resume.name = name
                                vm.resume.phone = phoneNumber
                                vm.resume.email = email
                                vm.resume.linkedin = linkedIn
                                vm.resume.github = gitHub
                                navigateNext = true
                            }) {
                                Text("Next")
                                    .padding()
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: 375)
                                    .background(Color.customLightBlue)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                            }
                            .navigationDestination(isPresented: $navigateNext) {
                                EducationView()
                            }
                            
                        }
                        .padding(.top, 50)
                    }
                    
                }
                .frame(width: 375)
            }
        }
    }
}

#Preview {
    InitialEntryView()
        .environmentObject(ResumeViewModel())
}
