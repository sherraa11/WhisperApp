//
//  ContentView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI

struct RootView: View {
    @AppStorage("on_boarding") var onBoarding : Bool = false
    @State var showHome = UserDefaults.standard.value(forKey: "showHome") as? Bool ?? false
    var body: some View {
            if !onBoarding{
                OnBoardingFlow()
            }else if !showHome {
                AuthentecationView()
            }else if showHome {
                HomeView()
            }
    }
}

#Preview {
    RootView()
}
