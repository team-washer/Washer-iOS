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
    @State var nameTextField: String = ""
    @State var nameIsError: Bool = false
    @State var schoolNumberTextField: String = ""
    @State var schoolNumberIsError: Bool = false
    @State var domitoryRoomTextField: String = ""
    @State var domitoryRoomIsError: Bool = false

    var body: some View {
        VStack(spacing: 34) {
            ZStack {
                HStack {
                    WasherAsset.washerLeftButton.swiftUIImage
                        .padding(.leading, 26)

                    Spacer()
                }

                Spacer()

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

            WasherTextField(
                "이름을 입력해주세요",
                text: $nameTextField,
                title: "이름",
                errorText: "이름을 잘못 입력했습니다.",
                isError: nameIsError
            )
            .padding(.top, 38)

            WasherTextField(
                "학번을 입력해주세요",
                text: $schoolNumberTextField,
                title: "학번",
                errorText: "숫자 4자리만 입력이 가능합니다. (ex.3314)",
                isError: schoolNumberIsError
            )

            WasherTextField(
                "기숙사 호실을 입력해주세요",
                text: $domitoryRoomTextField,
                title: "호실",
                errorText: "숫자 3자리만 입력이 가능합니다. (ex.415)",
                isError: domitoryRoomIsError
            )

            WasherButton(
                text: "다음",
                horizontalPadding: 173,
                verticalPadding: 17
            )

            Spacer()
        }
    }
}

#Preview {
    SignUpView(authViewModel: AuthViewModel())
}
