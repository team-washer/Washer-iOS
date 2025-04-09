//
//  SignInView.swift
//  Washer
//
//  Created by 서지완 on 3/12/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @StateObject var authViewModel: AuthViewModel
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
        ZStack {
            Color.white.ignoresSafeArea()
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
                errorText: "비밀번호는 8~16자, 특수문자 포함 필수",
                isError: computedPasswordError,
                isSecure: true
            )
            .padding(.top, 34)

            Button {
                isLoggedIn.toggle()
                Haptic.impact(style: .soft)
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

            WasherButton(
                text: "로그인",
                horizontalPadding: 166,
                verticalPadding: 17
            ) {
                authViewModel.setupEmail(email: emailTextField)
                authViewModel.setupPassword(password: passwordTextField)
                authViewModel.signIn { statusCode in
                    if (200...299).contains(statusCode) {
                        print("\(statusCode) | 로그인 성공")

                        if isLoggedIn {
                            let email = "\(emailTextField)@gsm.hs.kr"
                            let password = passwordTextField

                            UserDefaults.standard.set(email, forKey: "savedEmail")
                            UserDefaults.standard.set(password, forKey: "savedPassword")
                            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")

                            print("✅ 로컬 저장 완료: \(email), \(password), 로그인 상태 유지: \(isLoggedIn)")
                        }
                    } else {
                        print("\(statusCode) | 로그인 실패")
                    }
                }
            }
            .disabled(
                computedEmailError ||
                computedPasswordError ||
                emailTextField.isEmpty ||
                passwordTextField.isEmpty
            )
            .padding(.top, 111)

            HStack(spacing: 12) {
                Text("아아디 찾기")

                Rectangle()
                    .frame(width: 1, height: 12)
                    .color(.gray200)

                Text("비밀번호 찾기")

                Rectangle()
                    .frame(width: 1, height: 12)
                    .color(.gray200)

                Text("회원가입")
            }
            .color(.gray700)
            .font(.pretendard(.regular, size: 12))
            .padding(.top, 14)

            Spacer()
        }
    }
}
}

#Preview {
    SignInView(authViewModel: AuthViewModel())
}
