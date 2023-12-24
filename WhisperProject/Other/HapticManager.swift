//
//  HapticManager.swift
//  SwfitfulThinkingPart 2
//
//  Created by Abdelrahman Shera on 25/10/2023.
//

import SwiftUI

class HapticManager {
    
    
    static let shared = HapticManager()
    
    func notification( type: UINotificationFeedbackGenerator.FeedbackType) {
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
        
    }
    
    func impact(style : UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
//    HapticManager.shared.notification(type: .success)
//    HapticManager.shared.impact(style: .light)
}
