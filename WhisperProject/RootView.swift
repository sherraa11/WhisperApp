//
//  ContentView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI

struct RootView: View {
    @AppStorage("on_boarding") var onBoarding : Bool = false
    @AppStorage("showHome") var showHome : Bool = false
    
    var body: some View {
            if !onBoarding{
                OnBoardingFlow()
            }else if !showHome  {
                    AuthentecationView()
            }else if showHome  {
                HomeTabView()
            }
    }
}

#Preview {
    RootView()
}
