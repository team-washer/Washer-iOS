//
//  WasherTextField.swift
//  Washer
//
//  Created by 서지완 on 3/15/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import SwiftUI

struct WasherTextField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    var title: String
    var placeholder: String
    var errorText: String
    var isError: Bool
    var onSubmit: () -> Void

    private var borderColor: Color {
        if isError {
            return .red
        } else {
            return .color(.gray50)
        }
    }

    public init(
        _ placeholder: String = "",
        text: Binding<String>,
        title: String = "",
        errorText: String = "",
        isError: Bool = false,
        onSubmit: @escaping () -> Void = {}
    ) {
        self._text = text
        self.placeholder = placeholder
        self.title = title
        self.errorText = errorText
        self.isError = isError
        self.onSubmit = onSubmit
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if !title.isEmpty {
                Text(title)
                    .font(.pretendard(.bold, size: 14))
                    .color(.main100)
            }

            TextField(placeholder, text: $text)
                .padding(.horizontal, 16)
                .frame(height: 44)
                .onSubmit(onSubmit)
                .focused($isFocused)
                .color(.gray700)
                .font(.pretendard(.semiBold, size: 14))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .color(.gray50)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(borderColor)
                }
                .cornerRadius(8)
                .onTapGesture {
                    isFocused = true
                }

            if isError {
                Text(errorText)
                    .foregroundStyle(.red)
                    .font(.pretendard(.regular, size: 12))
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SignInView()
}
