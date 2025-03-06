import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ResumeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.customDarkGray
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    
                    Spacer()
                    

                    Image("rrLogo")
                        .resizable()
                        .frame(width: 106, height: 167)
                    
                    Spacer()

                    
                    Text("Rapid Resume")
                        .font(.custom("SF Pro", size: 44))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                    
                    Text("Effortless Resume Creation")
                        .font(.custom("SF Pro", size: 20))
                        .foregroundColor(.softYellow)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50)
                    
                   
                    VStack(spacing: 15) {
                    
                        
                        NavigationLink(destination: InitialEntryView()) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 220, height: 50)
                                .background(Color.customLightBlue)
                                .cornerRadius(25)
                                .padding(.bottom, 3)
                        }

                        NavigationLink(destination: AboutView()) {
                            Text("Learn More")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 220, height: 50)
                                .background(Color.black)
                                .cornerRadius(25)
                        }
                    }
                    .padding(.bottom, 100)

                    Spacer()
                }
                .padding()
            }
        }
        .environmentObject(vm)
        .navigationTitle("Resume")
        .navigationBarBackButtonHidden(true)
        .tint(.white)
    }
}

#Preview {
    ContentView()
}
