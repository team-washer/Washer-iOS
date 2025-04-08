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
            WasherTextField("이메일을 입력해주세요.", text: $emailTextField, title: "이메일", errorText: "잘못 입력했습니다.", isError: showError)
        }
    }
}

#Preview {
    SignInView()
}
