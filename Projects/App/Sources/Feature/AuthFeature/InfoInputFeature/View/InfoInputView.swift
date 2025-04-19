//
//  InfoInputView.swift
//  Washer
//
//  Created by 서지완 on 3/15/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import SwiftUI

import SwiftUI

struct InfoInputView: View {
    @StateObject var authViewModel: AuthViewModel
    @State var nameTextField: String = ""
    @State var nameIsError: Bool = false
    @State var schoolNumberTextField: String = ""
    @State var schoolNumberIsError: Bool = false
    @State var domitoryRoomTextField: String = ""
    @State var domitoryRoomIsError: Bool = false
    @State var selectedGender: String = "남자"
    let genders = ["남자", "여자"]

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
            .padding(.horizontal, 26)
            .padding(.top, 34)

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
            .padding(.horizontal, 26)
            .padding(.top, 34)

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
            .padding(.horizontal, 26)
            .padding(.top, 34)

            HStack {
                Text("성별")
                    .font(.pretendard(.bold, size: 14))
                    .color(.main100)
                    .padding(.top, 34)

                Spacer()
            }
            .padding(.leading, 26)

            HStack(spacing: 4) {
                ForEach(genders, id: \.self) { gender in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(selectedGender == gender ? Color.color(.main300) : Color.color(.gray50))

                        Text(gender)
                            .font(.pretendard(.semiBold, size: 14))
                            .color(.gray700)
                    }
                    .frame(height: 42)
                    .onTapGesture {
                        selectedGender = gender
                        Haptic.impact(style: .soft)
                    }
                }
            }
            .padding(.horizontal, 26)
            .padding(.top, 8)

            Spacer()

            Rectangle()
                .frame(height: 2)
                .color(.gray50)

            WasherButton(
                text: "다음",
                horizontalPadding: 26
            ) {}
                .disabled(!isFormValid)
                .padding(.top, 10)
                .padding(.bottom, 30)
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
    InfoInputView(authViewModel: AuthViewModel())
}
