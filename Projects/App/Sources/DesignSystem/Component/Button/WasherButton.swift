//
//  WasherButton.swift
//  Washer
//
//  Created by 서지완 on 4/8/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import SwiftUI

public struct WasherButton: View {
    var text: String
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
    var action: () -> Void

    @State private var isPressed = false

    public init(
        text: String,
        horizontalPadding: CGFloat = 16,
        verticalPadding: CGFloat = 8,
        action: @escaping () -> Void = {}
    ) {
        self.text = text
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.action = action
    }

    public var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(text)
                .font(.pretendard(.semiBold, size: 14))
                .color(.gray50)
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(isPressed ? Color.color(.main100) : Color.color(.main100))

                )
                .scaleEffect(isPressed ? 0.9 : 1.0)
            

        }
        .buttonStyle(PlainButtonStyle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in self.isPressed = true }
                .onEnded { _ in
                    self.isPressed = false
                    self.action()
                }
        )
    }
}

#Preview {
    SignInView()
}
