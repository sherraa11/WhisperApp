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
        VStack{
            if selectedTab == 1 {
                OnboardingBaseView(headerText: OnboardingModel.First.header, bodyText: OnboardingModel.First.body, image: OnboardingModel.First.image)
                Spacer()
                RepeatedButton(buttonName: buttonName, backgroundColor: .terqwaz, textColor: .white, borderColor: .clear)
                    .padding(.bottom,15)
                    .onTapGesture {
                        
                            selectedTab += 1
                            if selectedTab > 3 {
                                Skip()
                            
                        }
                    }
                RepeatedButton(buttonName: "Skip", backgroundColor: .white, textColor: .black, borderColor: .black)
                Spacer()
            } else if selectedTab == 2 {
                OnboardingBaseView(headerText: OnboardingModel.Second.header, bodyText: OnboardingModel.Second.body, image: OnboardingModel.Second.image)
                Spacer()
                RepeatedButton(buttonName: buttonName, backgroundColor: .terqwaz, textColor: .white, borderColor: .clear)
                    .padding(.bottom,15)
                    .onTapGesture {
                            selectedTab += 1
                        if selectedTab > 3 {
                            Skip()
                        }
                    }
                RepeatedButton(buttonName: "Skip", backgroundColor: .white, textColor: .black, borderColor: .black)
                Spacer()
            } else if selectedTab == 3 {
                OnboardingBaseView(headerText: OnboardingModel.Third.header, bodyText: OnboardingModel.Third.body, image: OnboardingModel.Third.image)
                Spacer()
                RepeatedButton(buttonName: buttonName, backgroundColor: .terqwaz, textColor: .white, borderColor: .clear)
                    .padding(.bottom,15)
                    .onTapGesture {
                                Skip()
                    }
                RepeatedButton(buttonName: "", backgroundColor: .clear, textColor: .clear, borderColor: .clear)
                Spacer()
            }
        }.onChange(of: selectedTab) { oldValue, newValue in
            renameButton()
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
        withAnimation(.easeInOut) {
            onBoarding = true
        }
        
    }
    func renameButton(){
        if selectedTab == 3 {
            buttonName = "Continue"
        } else {
            buttonName = "Next"
        }
    }
    struct RepeatedButton : View {
        let buttonName: String
        let backgroundColor : Color
        let textColor : Color
        let borderColor : Color
        var body: some View {
            Text(buttonName)
                .font(.custom("Poppins", size: 18))
                .fontWeight(.semibold)
                .foregroundStyle(textColor)
                .frame(width: 321, height: 49)
                .background(backgroundColor)
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: 1.0)
                }
            
        }
    }
}
