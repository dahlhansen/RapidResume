//
//  InitialEntryView.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 26/02/2025.
//

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
                LinearGradient(gradient: Gradient(colors: [Color.paleBlue, Color.darkBlue]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("The Basics")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    
                    TextField("Enter Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(radius: 3)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.darkBlue)
                    
                    TextField("Enter Phone Number", text: $phoneNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(radius: 3)
                        .multilineTextAlignment(.center)
                    
                    TextField("Enter desired email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(radius: 3)
                        .multilineTextAlignment(.center)
                    
                    TextField("linkedin.com/in/", text: $linkedIn)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(radius: 3)
                        .multilineTextAlignment(.center)
                    
                    TextField("Github.com/", text: $gitHub)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(radius: 3)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    
                    
                    
                    Button(action: {
                        vm.resume.name = name
                        vm.resume.phone = phoneNumber
                        vm.resume.email = email
                        vm.resume.linkedin = linkedIn
                        vm.resume.github = gitHub
                        navigateNext = true
                        
                        print(vm.resume)
                    }){
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
                        EducationView()
                    }
                    
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    InitialEntryView()
}


