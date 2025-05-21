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
    @State var authenticationCodeSendSuccess: Bool = false
    @State var authenticationButtonText: String = "인증번호 발송"
    @State var authenticationCodeBottomText: String = ""
    @State var isAuthCodeButtonClicked: Bool = false


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
                    isError: Validator.hasEmailError(emailTextField)
                )
                .padding(.leading, 26)
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
                    .padding(.trailing, 18)
                    .padding(.top, 20)
            }
            .padding(.top, 72)

            WasherButton(
                text: authenticationButtonText,
                horizontalPadding: 26
            ) {
                authViewModel.setupEmail(email: emailTextField)
                authViewModel.emailSend { statusCode in
                    isAuthCodeButtonClicked = true
                    if (200...299).contains(statusCode) {
                        print("SignUpView | 발송 성공")

                        authenticationCodeBottomText = "인증번호가 발송되었습니다."
                        authenticationButtonText = "인증번호 재발송"
                        authenticationCodeSendSuccess = true
                    } else {
                        print("SignUpView | 발송 실패")
                        authenticationCodeBottomText = "인증번호 발송에 실패하였습니다."
                    }
                }
            }
            .disabled(emailTextField.isEmpty || Validator.hasEmailError(emailTextField))
            .padding(.top, 18)

            HStack(alignment: .bottom, spacing: 10) {
                WasherTextField(
                    "인증번호를 입력해주세요",
                    text: $authenticationCodeNumberTextField,
                    title: "인증코드",
                    errorText: "비밀번호가 틀렸습니다.",
                    isError: authenticationCodeIsError
                )

                Button {

                } label: {
                    Text("확인")
                        .foregroundStyle(.white)
                        .font(.pretendard(.semiBold, size: 12))
                        .padding(.vertical, 14)
                        .padding(.horizontal, 35)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .color(.main100)
                        )
                }
                .disabled(!Validator.isValidAuthCode(authenticationCodeNumberTextField))
                .opacity(Validator.isValidAuthCode(authenticationCodeNumberTextField) ? 1.0 : 0.5)
            }
            .padding(.horizontal, 26)
            .padding(.top, 34)

            HStack {
                if isAuthCodeButtonClicked {
                    Text(authenticationCodeBottomText)
                        .font(.pretendard(.regular, size: 12))
                        .color(authenticationCodeSendSuccess ? .gray400 : .error)
                        .padding(.leading, 26)
                        .padding(.top, 6)
                }

                Spacer()
            }

            WasherTextField(
                "8~16자 영어, 숫자, 특수문자 1개 이상",
                text: $passwordTextField,
                title: "비밀번호",
                errorText: "비밀번호는 8~16자, 특수문자 포함 필수",
                isError: Validator.hasPasswordError(passwordTextField),
                isSecure: true
            )
            .padding(.top, 34)
            .padding(.horizontal, 26)

            WasherTextField(
                "비밀번호를 다시 입력해주세요",
                text: $passwordCheckTextField,
                errorText: "비밀번호가 틀렸습니다.",
                isError: passwordCheckIsError,
                isSecure: true
            )
            .onChange(of: passwordCheckTextField) { _ in
                passwordCheckIsError = Validator.hasPasswordCheckError(passwordTextField, passwordCheckTextField)
            }
            .padding(.top, 8)
            .padding(.horizontal, 26)

            Spacer()

            Rectangle()
                .frame(height: 2)
                .color(.gray50)

            WasherButton(
                text: "완료",
                horizontalPadding: 26
            ) {}
                .disabled(!Validator.isSignUpFormValid(
                    email: emailTextField,
                    password: passwordTextField,
                    passwordCheck: passwordCheckTextField
                ))
                .padding(.top, 10)
                .padding(.bottom, 30)
        }
    }
}

extension Validator {
    static func hasEmailError(_ email: String) -> Bool {
        !email.isEmpty && !isValidEmail(email)
    }

    static func hasPasswordError(_ password: String) -> Bool {
        !password.isEmpty && !isValidPassword(password)
    }

    static func hasPasswordCheckError(_ password: String, _ passwordCheck: String) -> Bool {
        !passwordCheck.isEmpty && password != passwordCheck
    }

    static func isSignUpFormValid(email: String, password: String, passwordCheck: String) -> Bool {
        isValidEmail(email) &&
        isValidPassword(password) &&
        password == passwordCheck &&
        !email.isEmpty &&
        !password.isEmpty &&
        !passwordCheck.isEmpty
    }

    static func isValidAuthCode(_ code: String) -> Bool {
        let pattern = #"^\d{5}$"#
        return code.range(of: pattern, options: .regularExpression) != nil
    }
}

#Preview {
    SignUpView(authViewModel: AuthViewModel())
}
