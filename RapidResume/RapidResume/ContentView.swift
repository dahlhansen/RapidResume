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
                LinearGradient(gradient: Gradient(colors: [Color.mediumBlue, Color.darkBlue]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    
                    
                    
                    Spacer()
                    
                    Image("rrlogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190, height: 200)
                    
                    Text("RAPID RESUME")
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(.electricYellow)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        
                        .font(.custom("Poppins-Bold", size: 48))
                        .padding(.bottom, 5)
                    
                    

                    Text("Effortless Resume Creation")
                    
                        .fontWeight(.heavy)
                        .foregroundColor(.electricYellow)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .padding(.bottom, 50)
                        .font(.custom("Poppins-Bold", size: 16))
                    
                    
                    
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
                        
                        NavigationLink(destination: InitialEntryView()) {
                            Text("Learn More")
                                .font(.headline)
                                .foregroundColor(Color.darkBlue)
                                .frame(width: 220, height: 50)
                                .background(Color.paleBlue)
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
