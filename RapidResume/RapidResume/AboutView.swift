import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Color.customDarkGray
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 42, height: 43)
                        .foregroundStyle(Color.white)
                    
                    Text("About Rapid Resume")
                        .font(.custom("Poppins-Bold", size: 36))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                    
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
