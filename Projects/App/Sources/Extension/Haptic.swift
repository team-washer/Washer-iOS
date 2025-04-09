//
//  Haptic.swift
//  Washer
//
//  Created by 서지완 on 4/8/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import SwiftUI

final class Haptic {
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
