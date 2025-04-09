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
                errorText: "이름은 한글 2~4자여야 합니다.",
                isError: nameIsError
            )
            .padding(.top, 38)
            .onChange(of: nameTextField) { newValue in
                nameTextField = String(newValue.prefix(4))

                let isOnlyHangul = nameTextField.allSatisfy { $0.isHangul }
                nameIsError = !(isOnlyHangul && (2...4).contains(nameTextField.count))
            }

            WasherTextField(
                "학번을 입력해주세요",
                text: $schoolNumberTextField,
                title: "학번",
                errorText: "형식이 올바르지 않습니다. (예: 2312)",
                isError: schoolNumberIsError
            )
            .onChange(of: schoolNumberTextField) { newValue in
                schoolNumberTextField = String(newValue.prefix(4)).filter { $0.isNumber }
                schoolNumberIsError = !isValidSchoolNumber(schoolNumberTextField)
            }

            WasherTextField(
                "기숙사 호실을 입력해주세요",
                text: $domitoryRoomTextField,
                title: "호실",
                errorText: "형식이 올바르지 않습니다. (예: 315)",
                isError: domitoryRoomIsError
            )
            .onChange(of: domitoryRoomTextField) { newValue in
                domitoryRoomTextField = String(newValue.prefix(3)).filter { $0.isNumber }
                domitoryRoomIsError = !isValidRoomNumber(domitoryRoomTextField)
            }

            WasherButton(
                text: "다음",
                horizontalPadding: 173,
                verticalPadding: 17
            ) {}
                .disabled(!isFormValid)

            Spacer()
        }
    }

    // MARK: - 정규식 검사 함수들

    func isValidName(_ name: String) -> Bool {
        let regex = #"^[가-힣]{2,4}$"#
        return name.range(of: regex, options: .regularExpression) != nil
    }

    func isValidSchoolNumber(_ number: String) -> Bool {
        let regex = #"^[1-3][1-4](0[1-9]|1[0-8])$"#
        return number.range(of: regex, options: .regularExpression) != nil
    }

    func isValidRoomNumber(_ number: String) -> Bool {
        let regex = #"^[2-5](0[0-9]|1[0-9]|20)$"#
        return number.range(of: regex, options: .regularExpression) != nil
    }

    var isFormValid: Bool {
        return isValidName(nameTextField) &&
               isValidSchoolNumber(schoolNumberTextField) &&
               isValidRoomNumber(domitoryRoomTextField) &&
               !nameTextField.isEmpty &&
               !schoolNumberTextField.isEmpty &&
               !domitoryRoomTextField.isEmpty
    }
}

#Preview {
    SignUpView(authViewModel: AuthViewModel())
}
