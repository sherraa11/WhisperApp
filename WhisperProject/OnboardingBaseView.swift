//
//  OnboardingBaseView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI

struct OnboardingBaseView: View {
    let headerText : String
    let bodyText : String
    let image : Image
    var body: some View {
            VStack(alignment: .leading, spacing:5){
                image
                    .resizable()
                    .frame(width: 370, height: 380)
                
                
                Group {
                    Text(headerText)
                        .foregroundColor(Color.black)
                        .font(.custom("Poppins", size: 20))
                        .fontWeight(.semibold)
                        .lineSpacing(4)
                        .padding(.bottom , 5)
                    
                    
                    Text(bodyText)
                        .foregroundColor(Color.primary)
                        .font(.custom("Poppins", size: 16))
                        .fontWeight(.medium)
                        .opacity(0.7)
                        .lineSpacing(4)
                        .frame(height: 72)
                    
                }.padding(.leading , 25)
                    
                
               
            }
        }
}






#Preview {
    OnboardingBaseView(headerText: "Connect with Friends \nand Family", bodyText: "Connecting with Family and Friends \nprovides a sense of belonging and\nsecurity ", image:Image(.ONBOARDING_1))
}

