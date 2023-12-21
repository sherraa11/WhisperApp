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
            
            //MARK: - tab1
            if selectedTab == 1 {
                OnboardingBaseView(headerText: OnboardingModel.First.header, bodyText: OnboardingModel.First.body, image: OnboardingModel.First.image)
                Spacer()
                RepeatedButton(buttonName: buttonName, backgroundColor: .terqwaz, textColor: .white, borderColor: .clear)
                    .padding(.bottom,15)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            selectedTab += 1
                            if selectedTab > 3 {
                                Skip()
                            }
                        }
                    }
                RepeatedButton(buttonName: "Skip", backgroundColor: .white, textColor: .black, borderColor: .black)
                    .onTapGesture {
                        withAnimation {
                            Skip()
                        }
                    }
                Spacer()
                
                //MARK: - tab 2
            } else if selectedTab == 2 {
                OnboardingBaseView(headerText: OnboardingModel.Second.header, bodyText: OnboardingModel.Second.body, image: OnboardingModel.Second.image)
                Spacer()
                RepeatedButton(buttonName: buttonName, backgroundColor: .terqwaz, textColor: .white, borderColor: .clear)
                    .padding(.bottom,15)
                    .onTapGesture {
                        withAnimation (.smooth){
                            selectedTab += 1
                            if selectedTab > 3 {
                                Skip()
                            }
                        }
                    }
                RepeatedButton(buttonName: "Skip", backgroundColor: .white, textColor: .black, borderColor: .black)
                    .onTapGesture {
                        withAnimation {
                            Skip()
                        }
                    }
                Spacer()
                //MARK: - tab 3
            } else if selectedTab == 3 {
                OnboardingBaseView(headerText: OnboardingModel.Third.header, bodyText: OnboardingModel.Third.body, image: OnboardingModel.Third.image)
                Spacer()
                RepeatedButton(buttonName: "Continue", backgroundColor: .terqwaz, textColor: .white, borderColor: .clear)
                    .padding(.bottom,15)
                    .onTapGesture {
                        withAnimation {
                            Skip()
                        }
                    }
                RepeatedButton(buttonName: "", backgroundColor: .clear, textColor: .clear, borderColor: .clear)
                Spacer()
            }
        }
    }
}

#Preview {
    OnBoardingFlow()
}


extension OnBoardingFlow {
    func Skip()  {
        onBoarding = true
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
