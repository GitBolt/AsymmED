import SwiftUI
import CryptoKit

struct SignatureView: View {
    
    @ObservedObject var cryptoKeys: CryptoKeys
    
    @State private var amountInput: String = ""
    @State private var senderInput: String = ""
    @State private var receiverInput: String = ""
    
    @State private var signature: String = ""
    
    @State private var amountOutput: String = ""
    @State private var senderOutput: String = ""
    @State private var receiverOutput: String = ""
    
    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @State private var showVerifyForm: Bool = false
    @State private var showRetryButton: Bool = false
    @State private var showContinueButton: Bool = false
    
    
    var body: some View {
        VStack {
            
            Text("Digital Signatures")
                .fontWeight(.bold)
                .font(.largeTitle)
                .foregroundColor(Color("HeadGrayMain"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 5)
            
            Text("Digital signatures use public and private key to verify the authenticity of transactions or messages, ensuring they haven't been tampered with and originated from a particular person.")
                .font(.title3)
                .foregroundColor(Color("ParaGrayMain"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 1)
            
            Divider()
            
            
            
            if showVerifyForm {
                HStack {
                    Text("Values must match for verification. You can just hit autofill to enter previous values!")
                        .foregroundColor(Color("ParaGray"))
                        .fontWeight(.bold)
                        .padding(.horizontal, 15)
                        .padding(.top, 10)
                    
                    Button("Autofill") {
                        amountOutput = amountInput
                        senderOutput = senderInput
                        receiverOutput = receiverInput
                    }                .frame(width: 80, height: 40)
                        .background(Color.clear)
                        .foregroundColor(Color("MainBlue"))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("MainBlue"), lineWidth: 2))
                        .listRowBackground(Color.clear)
                }
            } else {
                Text("Let's create and verify a transaction using your previously generated keypair!")
                    .foregroundColor(Color("ParaGray"))
                    .fontWeight(.bold)
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
            }
            if !showVerifyForm {
                Form {
                    TextField("Enter Amount", text: $amountInput)
                        .cornerRadius(5)
                    
                    
                    Section(header: Text("Hit the icon to fill your public key")) {
                        HStack {
                            TextField("Sender", text: $senderInput)
                            Spacer()
                            Button(action: {
                                senderInput = cryptoKeys.publicKeyBase58Value
                            }) {
                                Image(systemName: "doc.on.clipboard.fill")
                                    .foregroundColor(Color("MainBlue"))
                                    .font(.system(size: 20))
                            }
                        }
                    }
                    
                    Section(header: Text("Hit the icon to fill a random public key")) {
                        HStack {
                            TextField("Receiver", text: $receiverInput)
                            Spacer()
                            Button(action: {
                                receiverInput = base58Encode(Curve25519.Signing.PrivateKey().publicKey.rawRepresentation)
                            }) {
                                Image(systemName: "repeat")
                                    .foregroundColor(Color("MainBlue"))
                                    .font(.system(size: 30))
                            }
                        }
                    }
                    
                    Section(header: Text("Previously generated private key for signing (Read only)")) {
                        TextField("Private Key", text: $cryptoKeys.privateKeyBase58Value)
                            .disabled(true)
                            .foregroundColor(Color("ParaGray2"))
                    }
                    
                    if !signature.isEmpty{
                        Section {
                            HStack{
                                Text("Signature: ")
                                    .foregroundColor(Color("ParaGray"))
                                
                                Text(signature)
                                    .foregroundColor(Color("HeadGrayMain"))
                            }
                        }
                    }
                    
                    
                    if showRetryButton {
                        Button(action: {
                            createSignature()
                        }, label: {
                            Image(systemName: "arrow.counterclockwise")
                                .frame(width: 35, height: 35)
                                .background(Color.clear)
                                .foregroundColor(Color("MainBlue"))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MainBlue"), lineWidth: 2))
                        }).listRowBackground(Color.clear)
                            .padding(.horizontal, 20)
                    }
                    HStack{
                        Spacer()
                        Button(showRetryButton ? "Let's verify" : "Generate Signature") {
                            if showRetryButton {
                                showVerifyForm = true
                            } else {
                                if amountInput.isEmpty || senderInput.isEmpty || receiverInput.isEmpty {
                                    alertMessage = "Please enter all values"
                                    showAlert = true
                                } else {
                                    showAlert = false
                                    createSignature()
                                    showRetryButton = true
                                }
                            }
                        }
                        .frame(width: 250, height: 50)
                        .background(Color.clear)
                        .font(.title3)
                        .foregroundColor(Color("MainBlue"))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("MainBlue"), lineWidth: 2))
                        Spacer()
                    }                        .listRowBackground(Color.clear)
                    
                    
                }
                .padding(.horizontal, 20)
                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            } else {
                Form() {
                    Section(header:Text("Generated signature")) {
                        TextField("Signature", text: $signature)
                            .disabled(true)
                            .foregroundColor(Color("ParaGray2"))
                        
                    }
                    
                    
                    Section {
                        TextField("Amount", text: $amountOutput)
                    }
                    
                    Section {
                        TextField("Sender", text: $senderOutput)
                    }
                    
                    Section
                    {
                        TextField("Receiver", text: $receiverOutput)
                    }
                    
                    HStack{
                        Spacer()
                        
                        Button("Verify Signature") {
                            
                            if amountOutput.isEmpty || senderOutput.isEmpty || receiverOutput.isEmpty {
                                alertMessage = "Please enter all values"
                                showAlert = true
                            }else {
                                verifySignature()
                            }
                        }    .frame(width: 250, height: 50)
                            .background(Color.clear)
                            .font(.title3)
                            .foregroundColor(Color("MainBlue"))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("MainBlue"), lineWidth: 2))
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }
                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .padding(.horizontal, 20)
                
            }
            if showContinueButton {
                NavigationLink(destination: SeedPhraseView()) {
                    Text("Next: Seed Phrases")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 60)
                        .background(Color("MainBlue"))
                        .cornerRadius(15)
                        .padding(.top, 2)
                }
                
            }
            
        }
    }
    
    func createSignature() {
        do {
            let message = "\(amountInput)\(senderInput)\(receiverInput)"
            
            let messageData = message.data(using: .utf8)!
            
            let signatureData = try cryptoKeys.privateKey.signature(for: messageData)
            
            signature = signatureData.base64EncodedString()
            
        } catch {
            print(error)
        }
    }
    
    func verifySignature() {
        guard !signature.isEmpty else {
            showAlert(title: "Verification Error", message: "Please enter a signature.")
            return
        }
        
        do {
            let message = "\(amountOutput)\(senderOutput)\(receiverOutput)"
            
            let messageData = message.data(using: .utf8)!
            
            
            let signatureData = Data(base64Encoded: signature)!
            
            
            let newSignatureData = try! cryptoKeys.privateKey.signature(for: messageData)
            
            let newSignature = newSignatureData.base64EncodedString()
            
            let isValidSignature = cryptoKeys.publicKey.isValidSignature(signatureData, for: messageData)
            
            
            if isValidSignature || newSignature == signature {
                showAlert(title: "Success!", message: "The message signature is valid.")
                showContinueButton = true
            } else {
                showAlert(title: "Error!", message
                          : "The message signature is invalid. Did you enter different transaction values?")
            }
        }
    }
    
    
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    
}


