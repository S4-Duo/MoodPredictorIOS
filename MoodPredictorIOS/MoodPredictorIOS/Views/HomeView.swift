//
//  HomeView.swift
//  MoodPredictorIOS
//
//  Created by Reno Muijsenberg on 02/03/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresentent = false
    
    var body: some View {
        VStack {
            Spacer()
            Button(
                action: {
                    isCustomCameraViewPresentent.toggle()
                },
                label: {
                    Text("Take photo of the day").padding(10)
                }
            ).buttonStyle(.borderedProminent).padding(.bottom)
                .fullScreenCover(isPresented: $isCustomCameraViewPresentent, content: {
                CustomCameraView(capturedImage: $capturedImage, isPresent: $isCustomCameraViewPresentent).ignoresSafeArea()
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
