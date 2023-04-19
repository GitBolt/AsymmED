import SwiftUI

struct ProsAndConsView: View {
    var body: some View {
            ScrollView{
                VStack() {
                    Text("Pros and Cons")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(Color("HeadGrayMain"))
                        .padding(.horizontal, 15)
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Asymmetric encryption works differently than symmetric encryption, which we didn't cover, both come with their pros and cons. Let's understand that!")
                        .font(.title3)
                        .foregroundColor(Color("ParaGrayMain"))
                        .padding(.horizontal, 15)
                        .padding(.top, 1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    VStack {
                        Text("Pros")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .foregroundColor(Color("HeadGray"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                        
                        Group {
                            Text("1. Stronger security than symmetric encryption.")
                            Text("2. Public key can be shared without compromising security.")
                            Text("3. Can be used for digital signatures and secure key exchange.")
                            
                        }
                        .modifier(ProsConsTextStyle())
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, .blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .opacity(0.1)
                        .cornerRadius(10)
                    )
                    .padding(.horizontal, 20)
                    
                    
                    VStack {
                        Text("Cons")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .foregroundColor(Color("HeadGray"))
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        Group {
                            Text("1. Slower compared to symmetric encryption due to complex maths.")
                            
                            Text("2. Private key loss leads to inability to decrypt messages.")
                            
                            
                            Text("3. More complex leading to higher chance of error.")
                            
                            
                        }
                        .modifier(ProsConsTextStyle())
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, .blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .opacity(0.1)
                        .cornerRadius(10)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                    
                    
                    Image("Difference")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 330)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 20)
                    
                    Divider()
                    NavigationLink(destination: ConclusionView()) {
                        Text("Next: Conclusion")
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
}

struct ProsConsTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.leading)
            .foregroundColor(Color("ParaGray"))
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 10)
            .font(.system(size: 20))
            .padding(.horizontal, 20)
            .padding(.vertical, 3)
    }
}
