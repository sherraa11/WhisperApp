//
//  OnboardingModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import Foundation
import SwiftUI
enum OnboardingModel {
    case First , Second , Third
    
    var header : String {
        switch self {
        case.First :
            return "Connect with Friends \nand Family"
        case.Second :
            return "Make new friends \nwith ease"
        case.Third :
            return "Express yourself to \nthe world"
        }
    }
    
    var body : String {
        switch self {
        case.First:
            return "Connecting with Family and Friends \nprovides a sense of belonging and \nsecurity"
                    
        case.Second:
            return "Allowing you to make new Friends is   \nour Number one priority....."
        case.Third:
            return "Let your voice be heard on the internet \nthrough Momento features on the App \nwithout restrictions"
        }
    }
    
    var image : Image {
        switch self {
        case.First:
            return Image(.ONBOARDING_1)
        case.Second:
            return Image(.ONBOARDING_2)
        case.Third:
            return Image(.ONBOARDING_3)
        }
    }
}
