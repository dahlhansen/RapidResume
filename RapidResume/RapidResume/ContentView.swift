//
//  ContentView.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 26/02/2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ResumeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                Text("Start crafting your resume now")
                
                NavigationLink("Get Started", destination: InitialEntryView())
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 200)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                NavigationLink("How it works", destination: InitialEntryView())
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding()
        }
        .environmentObject(vm)
    }
}

#Preview {
    ContentView()
}
