import SwiftUI
import CryptoKit

struct WelcomeView: View {
    
    
    var body: some View {
            ZStack {
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .padding(.top, 50)
                    
                    Text("Welcome to AsymmED")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("HeadGray"))
                        .padding(.top, 30)
                    
                    Text("Learn Asymmetric Encryption and it's use in Blockchain.")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .foregroundColor(Color("ParaGray"))
                        .padding(.top, 10)
                        .padding(.horizontal, 20)
                    
                    
                    
                    NavigationLink(destination: IntroView()) {
                        Text("Get Started")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 250, height: 60)
                            .background(Color("MainBlue"))
                            .cornerRadius(15)
                    }
                    .padding(.top, 40)
                    
                    
                    
                    LinearGradient(gradient: Gradient(colors: [Color(.init(red: 0, green: 0, blue: 255, alpha: 0.3)), Color(.init(red: 255, green: 255, blue:255, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 420, height: 420)
                        .rotationEffect(.degrees(220)).cornerRadius(500).offset(y: 150).position( x:UIScreen.main.bounds.midX, y:100)
                    
                }
                
            }
    }
}

