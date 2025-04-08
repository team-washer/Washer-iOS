//
//  SignInView.swift
//  Washer
//
//  Created by 서지완 on 3/12/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State private var emailTextField: String = ""
    @State private var passwordTextField: String = ""
    @State private var isLoggedIn: Bool = false

    private var computedEmailError: Bool {
        !emailTextField.isEmpty && !Validator.isValidEmail(emailTextField)
    }

    private var computedPasswordError: Bool {
        !passwordTextField.isEmpty && !Validator.isValidPassword(passwordTextField)
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                WasherAsset.washerLeftButton.swiftUIImage
                    .padding(.leading, 16)
                    .padding(.top, 34)

                Spacer()
            }

            HStack {
                WasherAsset.washerLogo.swiftUIImage
                    .padding(.top, 5)
            }

            HStack(alignment: .top, spacing: 0) {
                WasherTextField(
                    "이메일을 입력해주세요.",
                    text: $emailTextField,
                    title: "이메일",
                    errorText: "이메일 형식이 맞지 않습니다.",
                    isError: computedEmailError
                )

                Text("@")
                    .font(.pretendard(.medium, size: 18))
                    .color(.gray400)
                    .padding(.top, 32)

                Text("gsm.hs.kr")
                    .font(.pretendard(.medium, size: 14))
                    .color(.gray400)
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .color(.gray50)
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
            }
            .padding(.top, 64)

            WasherTextField(
                "비밀번호를 입력해주세요.",
                text: $passwordTextField,
                title: "비밀번호",
                errorText: "비밀번호 형식이 맞지 않습니다.",
                isError: computedPasswordError,
                isSecure: true
            )
            .padding(.top, 34)

            Button {
                isLoggedIn.toggle()
            } label: {
                HStack(spacing: 2) {
                    Image(isLoggedIn ? "washerCheckButton" : "washerNoneCheckButton")

                    Text("로그인 상태 유지")
                        .font(.pretendard(.medium, size: 12))
                        .color(isLoggedIn ? .gray500 : .gray300)

                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.top, 6)
            }

            Spacer()
        }
    }
}

#Preview {
    SignInView()
}
