//
//  ContentView.swift
//  MoodPredictorIOS
//
//  Created by Brett Mulder on 13/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("TestImage").resizable()
                .frame(width: UIScreen.main.bounds.width, height: 350).scaledToFit()
            Text("BeHappy").font(Font.largeTitle.weight(.bold)).frame(maxWidth: .infinity, alignment: .center)
            GoogleLogin()
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
