//
//  ContentView.swift
//  MoodPredictorIOS
//
//  Created by Brett Mulder on 13/02/2023.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct ContentView: View {        
    var body: some View {
        VStack(alignment: .leading) {
            Image("TestImage").resizable()
                .frame(width: UIScreen.main.bounds.width, height: 350).scaledToFit()
            Text("BeHappy").font(Font.largeTitle.weight(.bold)).frame(maxWidth: .infinity, alignment: .center)
            GoogleSignInButton {
                guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
                // Create Google Sign In configuration object.
                let config = GIDConfiguration(clientID: clientID)
                GIDSignIn.sharedInstance.configuration = config
                
                // Start the sign in flow!
                GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                    guard error == nil else {
                        return
                    }
                    
                    guard let user = result?.user,
                          let idToken = user.idToken?.tokenString
                    else {
                        return
                    }
                    
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken,accessToken: user.accessToken.tokenString)
                    
                    Auth.auth().signIn(with: credential) {
                        result, error in
                        guard error == nil else {
                            return
                        }
                        
                        UserDefaults.standard.set(true, forKey: "signIn")
                    }

                }
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding().background(Color.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
