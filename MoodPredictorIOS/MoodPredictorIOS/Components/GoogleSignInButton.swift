//
//  GoogleSignInButton.swift
//  MoodPredictorIOS
//
//  Created by Brett Mulder on 02/03/2023.
//

import SwiftUI
import GoogleSignIn


struct GoogleSignInButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack{
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .mask(
                        Circle()
                    ).frame(height: 75)
                Text("Login with Google").padding()
            }.background(.white)
        }
        .frame(maxHeight: 50)
        .cornerRadius(20) /// make the background rounded
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 1)
        ).shadow(radius: 5)
    }
}


struct GoogleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton(action: {})
    }
}
