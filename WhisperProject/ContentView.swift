//
//  ContentView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("on_boarding") var onBoarding : Bool = false
    var body: some View {
        if !onBoarding{
            OnBoardingFlow()
        }else{
            AuthentecationView()
        }
    }
}

#Preview {
    ContentView()
}
