//
//  GoogleUserModel.swift
//  MoodPredictorIOS
//
//  Created by Brett Mulder on 02/03/2023.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase

class GoogleUserModel{
    func login(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            guard error == nil else {
                // ...
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                // ...
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // ...
        }
    }
}
