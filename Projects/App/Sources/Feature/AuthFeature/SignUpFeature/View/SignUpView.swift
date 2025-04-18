//
//  SignUpView.swift
//  Washer
//
//  Created by 서지완 on 3/12/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var authViewModel: AuthViewModel
    @State var emailTextField: String = ""
    @State var emailIsError: Bool = false
    @State var authenticationCodeNumberTextField: String = ""
    @State var authenticationCodeIsError: Bool = false
    @State var passwordTextField: String = ""
    @State var passwordIsError: Bool = false
    @State var passwordCheckTextField: String = ""
    @State var passwordCheckIsError: Bool = false
    @State var authenticationSuccess: Bool = false

    private var computedEmailError: Bool {
        !emailTextField.isEmpty && !Validator.isValidEmail(emailTextField)
    }

    private var computedPasswordError: Bool {
        !passwordTextField.isEmpty && !Validator.isValidPassword(passwordTextField)
    }

    private var computedPasswordCheckError: Bool {
        !passwordCheckTextField.isEmpty && passwordTextField != passwordCheckTextField
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    WasherAsset.washerLeftButton.swiftUIImage
                        .padding(.leading, 26)
                    Spacer()
                }

                VStack(spacing: 6) {
                    Text("회원가입")
                        .font(.pretendard(.bold, size: 18))
                        .foregroundStyle(.black)

                    Text("로그인 시 사용할 정보를 입력해주세요")
                        .font(.pretendard(.regular, size: 12))
                        .color(.gray300)
                }
            }
            .padding(.top, 50)

            HStack(alignment: .top, spacing: 0) {
                WasherTextField(
                    "이메일을 입력해주세요.",
                    text: $emailTextField,
                    title: "이메일",
                    errorText: "이메일 형식이 맞지 않습니다.",
                    isError: computedEmailError
                )
                .padding(.leading, 16)
                .padding(.trailing, 8)

                Text("@")
                    .font(.pretendard(.medium, size: 18))
                    .color(.gray400)
                    .padding(.top, 32)

                Text("gsm.hs.kr")
                    .font(.pretendard(.medium, size: 12))
                    .color(.gray400)
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .color(.gray50)
                    )
                    .padding(.horizontal, 8)
                    .padding(.trailing, 8)
                    .padding(.top, 20)
            }
            .padding(.top, 72)

            HStack(alignment: .bottom, spacing: 10) {
                WasherTextField(
                    "인증번호를 입력해주세요",
                    text: $authenticationCodeNumberTextField,
                    title: "인증코드",
                    errorText: "비밀번호가 틀렸습니다.",
                    isError: authenticationCodeIsError
                )

                Text("확인")
                    .font(.pretendard(.semiBold, size: 12))
                    .padding(.vertical, 14)
                    .padding(.horizontal, 35)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .color(.gray300)
                        )
            }
            .padding(.horizontal, 16)
            .padding(.top, 34)

            HStack {
                if authenticationSuccess == false {
                    Text("인증번호가 발송되었습니다 ")
                        .font(.pretendard(.regular, size: 12))
                        .color(.gray400)
                        .padding(.leading, 16)
                        .padding(.top, 6)
                }

                Spacer()
            }

            WasherTextField(
                "8~16자 영어, 숫자, 특수문자 1개 이상",
                text: $passwordTextField,
                title: "비밀번호",
                errorText: "비밀번호는 8~16자, 특수문자 포함 필수",
                isError: computedPasswordError,
                isSecure: true
            )
            .padding(.top, 34)
            .padding(.horizontal, 16)

            WasherTextField(
                "비밀번호를 다시 입력해주세요",
                text: $passwordCheckTextField,
                errorText: "비밀번호가 틀렸습니다.",
                isError: passwordCheckIsError,
                isSecure: true
            )
            .onChange(of: passwordCheckTextField) { _ in
                passwordCheckIsError = computedPasswordCheckError
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)

            Spacer()
        }
    }
}

#Preview {
    SignUpView(authViewModel: AuthViewModel())
}
