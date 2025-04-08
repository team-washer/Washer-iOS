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
    @State private var showError: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            Button {
                showError.toggle()
            } label: {
                Text("오류 발생!!버튼!!")
            }.padding(.bottom, 100)

            HStack(spacing: 0) {
                WasherTextField (
                    "이메일을 입력해주세요.",
                    text: $emailTextField,
                    title: "이메일",
                    errorText: "이메일 형식이 맞지 않습니다.",
                    isError: showError
                )
                Text("@")
                    .font(.pretendard(.medium, size: 18))
                    .color(.gray400)
                    .padding(.top, 20)

                Text("gsm.hs.kr")
                    .font(.pretendard(.medium, size: 14))
                    .color(.gray400)
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .color(.gray50)
                    )
                    .padding(.trailing, 16)
                    .padding(.leading, 16)
                    .padding(.top, 20)
            }
        }
    }
}

#Preview {
    SignInView()
}
