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
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.paleBlue, Color.darkBlue]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                VStack {
                    
                    Image("rrlogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190, height: 200)
                        .padding()

                    Text("Craft Your Resume In Minutes")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.electricYellow)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .padding(.top, 10)
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: InitialEntryView()) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(Color.paleBlue)
                                .frame(width: 220, height: 50)
                                .background(Color.mediumBlue)
                                .cornerRadius(25)
                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                                .padding(.top, 20)
                        }
                    }
                }
                .padding()
                .offset(y: -150)
            }
        }
        .environmentObject(vm)
    }
}

#Preview {
    ContentView()
}
