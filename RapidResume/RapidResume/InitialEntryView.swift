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
            VStack {
                
                Text("Let's get some of the basics down")
                
                Spacer()
                
                Text("Enter Your Name")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Enter Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 3)
                
                TextField("Enter Phone Number", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 3)
                
                TextField("Enter desired email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 3)
                
                TextField("linkedin.com/in/", text: $linkedIn)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 3)
                TextField("Github.com/", text: $gitHub)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 3)
                
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
                            .foregroundColor(.white)
                            .frame(maxWidth: 200)
                            .background(Color.blue)
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


