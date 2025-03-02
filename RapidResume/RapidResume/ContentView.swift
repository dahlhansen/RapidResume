//
//  ContentView.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 26/02/2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ResumeViewModel()
    
    let customDarkBlue = Color(red: 55/255, green: 67/255, blue: 210/255)
    let customElectricYellow = Color(red: 255/255, green: 255/255, blue: 50/255)
    
    let darkBlue = Color(red: 3/255, green: 4/255, blue: 94/255)
    let mediumBlue = Color(red: 0/255, green: 119/255, blue: 182/255)
    let brightBlue = Color(red: 0/255, green: 180/255, blue: 216/255)
    let lightBlue = Color(red: 144/255, green: 224/255, blue: 239/255)
    let paleBlue = Color(red: 202/255, green: 240/255, blue: 248/255)

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [paleBlue, darkBlue]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                VStack {
                    
                    Image("rrlogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 200)

                    Text("Craft Your Resume In Minutes")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .padding(.top, 10)
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: InitialEntryView()) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(paleBlue)
                                .frame(width: 220, height: 50)
                                .background(mediumBlue)
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
