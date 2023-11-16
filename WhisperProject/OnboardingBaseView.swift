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
        VStack(spacing:20){
            Spacer()
            image
                .resizable()
                .frame(width: 300, height: 300)
            
            Text(headerText)
                .foregroundColor(Color.primary)
                .font(.custom("Proxima Nova", size: 30))
                .fontWeight(.bold)
            
            Text(bodyText)
            .foregroundColor(Color.primary)
            .font(.custom("Proxima Nova", size: 18))
            .fontWeight(.regular)
            .frame(width: 370, height: 100)
            .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
    

}

