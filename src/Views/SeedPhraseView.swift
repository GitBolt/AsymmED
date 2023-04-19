import SwiftUI
import CryptoKit

struct SeedPhraseView: View {
    
    @State var seedPhrase = Mnemonic(strength: 128, wordlist: Wordlists.english)
    
    @State var privateKey = ""
    @State var publicKey = ""
    
    
    var body: some View {
            ScrollView{
                VStack {
                    
                    Text("Seed Phrase")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(Color("HeadGrayMain"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 5)
                    
                    Text("Seed or mnemonic phrases help us remember our private keys so we don't lose them. They are 12 or 24 word long random looking phrases that follow Bitcoin improvement proposal (BIP) 39.")
                        .font(.title3)
                        .foregroundColor(Color("ParaGrayMain"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 1)
                    
                    Divider()
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            seedPhrase = Mnemonic()
                            let privateKeyGet = try! P256.Signing.PrivateKey(rawRepresentation: seedPhrase.seed.prefix(32))
                            
                            privateKey = base58Encode(privateKeyGet.rawRepresentation)
                            publicKey = base58Encode(privateKeyGet.publicKey.rawRepresentation)
                            
                        }) {
                            Text("Generate Seed Phrase")
                                .fontWeight(.bold)
                                .frame(width: 250, height: 50)
                                .background(Color.clear)
                                .foregroundColor(Color("MainBlue"))
                                .padding(.horizontal, 10)
                                .font(.title3)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MainBlue"), lineWidth: 2))
                        }
                        Spacer()
                    }.padding(.vertical, 20)
                    
                    if !seedPhrase.phrase.isEmpty && !privateKey.isEmpty {
                        
                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .white]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .opacity(0.2)
                            .cornerRadius(10)
                            
                            LazyVGrid(
                                columns: [
                                    GridItem(.adaptive(minimum: 70))
                                ], spacing: 10
                            ) {
                                ForEach(seedPhrase.phrase, id: \.self) { word in
                                    Text(word)
                                        .fontWeight(.black)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .fixedSize()
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical,15)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Private Key:")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color("HeadGrayMain"))
                            Text("\(String(privateKey.prefix(16)))...\(String(privateKey.suffix(16)))")
                            
                                .font(.system(size: 16))
                                .foregroundColor(Color("HeadGray"))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .background(Color("LightBg"))
                                .cornerRadius(10)
                            
                            Text("Public Key:")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color("HeadGrayMain"))
                            Text("\(String(publicKey.prefix(16)))...\(String(publicKey.suffix(16)))")
                            
                            
                                .font(.system(size: 16))
                                .foregroundColor(Color("HeadGray"))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .background(Color("LightBg"))
                                .cornerRadius(10)
                        }
                        .padding(.vertical, 20)
                        Divider()
                        Text("Seed phrases use an algorithm called 'key derivation function' to create a private key. This process only goes one way, so you can't use a private key to create a seed phrase!")
                            .font(.title3)
                            .foregroundColor(Color("ParaGray"))
                        Divider()
                    }
                    
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                if !privateKey.isEmpty {
                    NavigationLink(destination: ProsAndConsView()) {
                        Text("Next: Pros and Cons")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 250, height: 60)
                            .background(Color("MainBlue"))
                            .cornerRadius(15)
                    }
                }
        }
    }
}

struct SeedPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        SeedPhraseView()
    }
}
