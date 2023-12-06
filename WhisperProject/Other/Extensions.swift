//
//  Extensions.swift
//  ChatApp
//
//  Created by Stephanie Diep on 2022-01-11.
//

import Foundation
import SwiftUI
import UIKit

// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Date {
    func formattedTime() -> String {
        let now = Date()
        let calendar = Calendar.current

        let formatter = DateFormatter()

        // Check if the date is today
        if calendar.isDateInToday(self) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: self)
        }

        // Check if the date is within the last 7 days
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: now),
           calendar.isDate(self, inSameDayAs: yesterday) {
            return "Yesterday"
        }

        // Check if the date is within the current week
        if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)),
           let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek),
           self >= startOfWeek && self <= endOfWeek {
            formatter.dateFormat = "EEEE"
            return formatter.string(from: self)
        }

        // For dates older than a week, return date in dd/MM/yyyy format
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}
