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

    var body: some View {
        VStack {
            Button {
                authViewModel.setupEmail(email: "s23053")
                authViewModel.setupPassword(password: "washertest1!")
                authViewModel.setupName(name: "서지완")
                authViewModel.setupGrade(grade: "3")
                authViewModel.setupClassRoom(classRoom: "3")
                authViewModel.setupNumber(number: "14")
                authViewModel.setupGender(gender: "MAN")
                authViewModel.setupRoom(room: "415")
                authViewModel.signUp { statusCode in
                    if (200...299).contains(statusCode) {
                        print("\(statusCode) | 회원가입 성공")
                    } else {
                        print("\(statusCode) | 회원가입 실패")
                    }
                }
            } label: {
                Text("회원가입 테스트 버튼")
            }

            Button {
                authViewModel.setupEmail(email: "s23053")
                authViewModel.setupPassword(password: "washertest1!")
                authViewModel.signIn { statusCode in
                    if (200...299).contains(statusCode) {
                        print("\(statusCode) | 로그인 성공")
                    } else {
                        print("\(statusCode) | 로그인 실패")
                    }
                }
            } label: {
                Text("로그인 테스트 버튼")
            }
        }
    }
}
