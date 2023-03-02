//
//  AuthenticationViewModel.swift
//  MoodPredictorIOS
//
//  Created by Brett Mulder on 02/03/2023.
//

import Foundation
import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    
    // Enum for the sign in status
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    // Setting the state to default .signedOut
    @Published var state: SignInState = .signedOut
    
    // Function for signing in
    func signIn() {
        // Check if there was a previous login, when there is one restore it, else proceed to the login steps
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        } else {
            // Get the client Id from the Firebase
            // It fetches the clientID from the GoogleService-Info.plist added to the project earlier
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // Create a Google Sign-In configuration object with the clientID
            let configuration = GIDConfiguration(clientID: clientID)
            
            // As you’re not using view controllers to retrieve the presentingViewController, access it through the shared instance of the UIApplication. Note that directly using the UIWindow is now deprecated, and you should use the scene instead
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            // Then, call signIn() from the shared instance of the GIDSignIn class to start the sign-in process. You pass the configuration object and the presenting controller.
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in authenticateUser(for: user, with: error)
            }
        }
    }
    
    // Function to authenticate the user
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        // Handle the error and return it early from the method.
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        // Get the idToken and accessToken from the user instance
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        // Use them to sign in to Firebase. If there are no errors, change the state to signedIn
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.state = .signedIn
            }
        }
    }
    
    // Function for signing out
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            
            // Set the login state to logged out
            state = .signedOut
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
