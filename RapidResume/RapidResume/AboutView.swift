//
//  AboutView.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 04/03/2025.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(gradient: Gradient(colors: [Color.mediumBlue, Color.darkBlue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    // App Title
                    Text("About Rapid Resume")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.electricYellow)
                        .padding(.top, 30)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                    
                    // App Description
                    Text("""
                    Finding a great job opportunity should be exciting, not frustrating. **Rapid Resume** was created to solve a common problem: discovering interesting jobs while on the go but not having an easy way to create a polished resume quickly.

                    Too often, online resume templates are rigid, clunky, or require endless formatting tweaks, turning what should be a simple process into a frustrating one.

                    With **Rapid Resume**, you can effortlessly craft a professional, well-structured resume without worrying about formatting. The app provides an **intuitive and streamlined experience**, allowing you to focus on your content while it takes care of the design. Whether you're applying from your phone or just need a quick update, **Rapid Resume ensures your application is always job-ready.**
                    """)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 25)
                        .padding(.top, 10)
                    
                    Spacer()
                }
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    AboutView()
}
