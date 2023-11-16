//
//  OnBoardingView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI

struct OnBoardingFlow: View {
    @State var buttonName : String = "Next"
    @State var selectedTab : Int = 1
    
    @AppStorage("on_boarding") var onBoarding : Bool = false
    
    var body: some View {
        ZStack {
            Color("notprimary").ignoresSafeArea()
            
            VStack {
                TabView(selection:$selectedTab) {
                    OnboardingBaseView(headerText: OnboardingModel.First.header, bodyText: OnboardingModel.First.body, image: OnboardingModel.First.icon).tag(1)
                    OnboardingBaseView(headerText: OnboardingModel.Second.header, bodyText: OnboardingModel.Second.body, image: OnboardingModel.Second.icon).tag(2)
                    OnboardingBaseView(headerText: OnboardingModel.Third.header, bodyText: OnboardingModel.Third.body, image: OnboardingModel.Third.icon).tag(3)
                }.tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height: 580)
                    .onChange(of: selectedTab) { _ , _ in
                        renameButton()
                    }
                
              Spacer()
                
                nextButton
                skipButton
            }
        }
    }
}
            
#Preview {
 OnBoardingFlow()
}


extension OnBoardingFlow {
    private var nextButton : some View {
        
        Text(buttonName)
            .font(.custom("Proxima Nova", size: 18))
            .fontWeight(.semibold)
            .frame(width: 319, height: 50)
            .background(Color("middleColor"))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .foregroundColor(.white)
            .padding(.bottom, 10)
            .onTapGesture {
                selectedTab += 1
                if selectedTab > 3 {
                    Skip()
                }
            }
        
    }
    private var skipButton : some View {
        Text("Skip")
            .font(.custom("Proxima Nova", size: 18))
            .fontWeight(.semibold)
            .foregroundColor(Color("middleColor"))
            .overlay(Text("........").foregroundColor(Color.primary).offset(y: 10))
            .onTapGesture {
                Skip()
            }
    }
    
    func Skip()  {
        withAnimation {
            onBoarding = true
        }
        
    }
    func renameButton(){
        if selectedTab == 3 {
            buttonName = "Start"
        } else {
            buttonName = "Next"
        }
    }
    
}
