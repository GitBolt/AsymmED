import SwiftUI
import CryptoKit

struct IntroView: View {
    @ObservedObject var cryptoKeys = CryptoKeys()
    @State private var isKeyGenerated = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var backButton: some View {Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }){
        HStack {
            Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            Text("Back")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 18))
        }
        .padding(5)
        .background(Color("MainBlue"))
        .cornerRadius(10)
        .position(x: 40, y: 15)
        
    }
        
    }
    var body: some View {
            ScrollView{
                VStack{
                    ZStack {
                        
                        LinearGradient(gradient:  Gradient(colors: [Color("MainBlue"), Color("MainBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .frame(width: 400, height: 500)
                            .cornerRadius(120)
                        
                        VStack{
                            Text("What is Asymmetric Encryption?")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.top, 80)
                                .multilineTextAlignment(.leading)
                            
                            Text("It is a type of encryption that uses two different keys, one for encryption (scrambling) and other for decryption (unscambling). This is known as public-key cryptography.")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .font(.title2)
                                .foregroundColor(Color.white)
                                .padding(.top, 1)
                                .padding(.horizontal, 40)
                        }
                    }.position( x:UIScreen.main.bounds.midX, y:100)
                    
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            cryptoKeys.generateKeys()
                            isKeyGenerated = true
                        }) {
                            Text("Generate My Keys")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("MainBlue"))
                                .frame(width: 250, height: 60)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius:15)
                                        .stroke(Color("MainBlue"), lineWidth:2)
                                )
                        }
                    }.offset(y: -100)
                    
                    
                    if isKeyGenerated {
                        
                        
                        VStack() {
                            
                            KeyView(keyType: "Public", key: cryptoKeys.publicKeyBase58)
                            KeyView(keyType: "Private", key: cryptoKeys.privateKeyBase58)
                            
                            Divider()
                            Text("Public and Private Key together form a 'Keypair'. Crypto wallets essentially generate and manage Keypairs for you.")
                                .font(.title3)
                                .padding(.horizontal,20)
                                .foregroundColor(Color("HeadGrayMain"))
                            Divider()
                        }.offset(y: -70)
                        
                        
                        NavigationLink(destination: SignatureView(cryptoKeys: cryptoKeys)) {
                            Text("Next: Signatures")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 250, height: 60)
                                .background(Color("MainBlue"))
                                .cornerRadius(15)
                        }.offset(y:-60)
                        
                        
                    }
                }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
}

struct KeyView: View {
    let keyType: String
    let key: String
    
    var body: some View {
        Divider()
        VStack {
            HStack {
                Text("\(keyType) Key:")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("HeadGray"))
                
                Text(key)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color("ParaGray"))
                    .background(Color("LightBg"))
                    .cornerRadius(10)
            }
            
            Text(keyType == "Public" ?
                 "You can share your public key with friends. It's like your username and this is used to identify you in blockchain transactions." :
                    "Your private key is like a password that gives you exclusive access to your blockchain wallet. Keep it safe and don't share it!")
            .font(.title3)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(Color("ParaGray2"))
            
        }.padding(.horizontal, 20)
        
    }
}


struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
