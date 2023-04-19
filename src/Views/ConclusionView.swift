//
//  ConclusionView.swift
//  Crp
//
//  Created by Bolt on 17/04/23.
//

import SwiftUI

struct ConclusionView: View {
    var body: some View {
            ScrollView{
                VStack {
                    Text("Conclusion")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(Color("HeadGrayMain"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 5)
                    
                    Text("We covered a variety of topics easily and in simple terms to understand asymmetric encryption. However, there is a lot more to learn!")
                        .font(.title3)
                        .foregroundColor(Color("ParaGrayMain"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 1)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                    Divider()
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .padding(.top, 5)
                    
                    VStack {
                        Text("Topics Covered")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color("HeadGray"))
                            .padding(.bottom, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Group {
                            Text("1. Public Keys and Private Keys")
                            
                            Text("2. Digital Signatures")
                            
                            Text("3. Seed Phrases")
                            
                            Text("4. Pros and Cons")
                            
                            Text("5. Conclusion")
                            
                            
                        }
                        .font(.system(size: 22))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("ParaGray"))
                        .fixedSize(horizontal: false, vertical: true)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, .blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .opacity(0.2)
                        .cornerRadius(10)
                    )
                    .padding(.horizontal, 15)
                    
                }
                Spacer()
                NavigationLink(destination: WelcomeView()) {
                    Text("Restart")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 60)
                        .background(Color("MainBlue"))
                        .cornerRadius(15)
                        .padding(.top, 2)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
            }
    }
}

struct ConclusionView_Previews: PreviewProvider {
    static var previews: some View {
        ConclusionView()
    }
}
