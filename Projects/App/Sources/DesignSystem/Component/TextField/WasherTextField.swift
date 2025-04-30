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
    var isSecure: Bool
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
        isSecure: Bool = false,
        onSubmit: @escaping () -> Void = {}
    ) {
        self._text = text
        self.placeholder = placeholder
        self.title = title
        self.errorText = errorText
        self.isError = isError
        self.isSecure = isSecure
        self.onSubmit = onSubmit
    }

    @State private var isSecureButton: Bool = true

    var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                if !title.isEmpty {
                    Text(title)
                        .font(.pretendard(.bold, size: 14))
                        .color(.main100)
                }

                HStack(spacing: 0) {
                    Group {
                        if isSecure && isSecureButton {
                            SecureField(placeholder, text: $text)
                        } else {
                            TextField(placeholder, text: $text)
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 42)
                    .onSubmit(onSubmit)
                    .focused($isFocused)
                    .foregroundColor(.color(.gray700))
                    .font(.pretendard(.semiBold, size: 12))

                    if isSecure {
                        Button {
                            isSecureButton.toggle()
                            Haptic.impact(style: .soft)
                        } label: {
                            Image(isSecureButton ? "washerPassword" : "washerNonePassword")
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                    }
                }
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
                        .font(.pretendard(.regular, size: 11))
                }
            }
            //.padding(.horizontal, 16)
        }
}
