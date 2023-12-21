//
//  ContentView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI

struct RootView: View {
    @AppStorage("on_boarding") var onBoarding : Bool = false
    @State var showHome = UserDefaults.standard.value(forKey: "showHome") 
    var body: some View {
            if !onBoarding{
                OnBoardingFlow()
            }else if (showHome == nil) {
                    AuthentecationView()
            }else if (showHome != nil) {
                HomeTabView()
            }
    }
}

#Preview {
    RootView()
}
