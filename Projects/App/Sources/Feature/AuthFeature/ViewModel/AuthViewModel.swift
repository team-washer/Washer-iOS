//
//  AuthViewModel.swift
//  Washer
//
//  Created by 서지완 on 3/12/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import Moya
import Foundation

public final class AuthViewModel: ObservableObject {

    // MARK: - Private Properties
    private let authProvider = MoyaProvider<AuthAPI>()

    // MARK: - User Info Properties
    private var email: String = ""
    private var password: String = ""
    private var name: String = ""
    private var gender: String = ""
    private var grade: String = ""
    private var classRoom: String = ""
    private var number: String = ""
    private var room: String = ""
    private var major: String = ""

    // MARK: - Additional Properties
    private var emailStatus: String = ""
    private var authCode: String = ""
    private var newPassword: String = ""
    private var newServePassword: String = ""
    private var passwordServe: String = ""

    // MARK: - Setup Methods
    func setupEmail(email: String) {
        self.email = "\(email)@gsm.hs.kr"
    }

    func setupPassword(password: String) {
        self.password = password
    }

    func setupName(name: String) {
        self.name = name
    }

    func setupGender(gender: String) {
        self.gender = gender
    }

    func setupGrade(grade: String) {
        self.grade = grade
    }

    func setupClassRoom(classRoom: String) {
        self.classRoom = classRoom
    }

    func setupNumber(number: String) {
        self.number = number
    }

    func setupRoom(room: String) {
        self.room = room
    }

    func setupMajor(major: String) {
        self.major = major
    }

    func setupEmailStatus(emailStatus: String) {
        self.emailStatus = emailStatus
    }

    func setupAuthCode(authCode: String) {
        self.authCode = authCode
    }

    func setupNewPassword(newPassword: String, checkPassword: String) {
        guard newPassword == checkPassword else { return }
        self.newPassword = newPassword
    }

    func setupNewServePassword(newPassword: String, checkPassword: String) {
        guard newPassword == checkPassword else { return }
        self.newServePassword = newPassword
    }

    // MARK: - Sign Up Request
    func signUp(completion: @escaping (Int) -> Void) {
        let param = SignUpRequest(
            email: email,
            password: password,
            name: name,
            grade: grade,
            classRoom: classRoom,
            number: number,
            gender: gender,
            room: room
        )

        authProvider.request(.signUp(param: param)) { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success(let result):
                let statusCode = result.statusCode

                // 🔹 응답 데이터 확인을 위해 출력
                if let responseString = String(data: result.data, encoding: .utf8) {
                    print("📥 서버 응답 (상태 코드: \(statusCode)):\n\(responseString)")
                }

                // 🔹 응답이 비어 있는지 확인
                guard !result.data.isEmpty else {
                    print("⚠️ 응답 본문이 비어 있습니다. (상태 코드: \(statusCode))")
                    DispatchQueue.main.async { completion(statusCode) }
                    return
                }

                do {
                    // JSON 변환 시도
                    let responseData = try result.mapJSON()
                    print("✅ JSON 변환 성공: \(responseData)")

                    DispatchQueue.main.async {
                        switch statusCode {
                        case 200...299:
                            print("🎉 회원가입 성공! (상태 코드: \(statusCode))")
                        case 400:
                            print("⚠️ [\(statusCode)] 잘못된 요청 - 입력값을 확인하세요.")
                        case 401:
                            print("🔑 [\(statusCode)] 인증 실패 - 로그인 정보를 확인하세요.")
                        case 403:
                            print("🚫 [\(statusCode)] 접근 금지 - 권한이 없습니다.")
                        case 500:
                            print("🔥 [\(statusCode)] 서버 오류 - 나중에 다시 시도하세요.")
                        default:
                            print("❓ 예상치 못한 상태 코드: \(statusCode), 응답 데이터: \(responseData)")
                        }
                        completion(statusCode)
                    }
                } catch {
                    print("❌ JSON 파싱 오류 발생 (상태 코드: \(statusCode)) - \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(-1)
                    }
                }

            case .failure(let err):
                print("🌐 네트워크 오류 발생! - \(err.localizedDescription)")
                DispatchQueue.main.async {
                    completion(0)
                }
            }
        }
    }

    func signIn(completion: @escaping (Int) -> Void) {
        let param = SignInRequest(
            email: email,
            password: password
        )

        authProvider.request(.signIn(param: param)) { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success(let result):
                let statusCode = result.statusCode

                if let responseString = String(data: result.data, encoding: .utf8) {
                    print("📥 서버 응답 (상태 코드: \(statusCode)):\n\(responseString)")
                }

                guard !result.data.isEmpty else {
                    print("⚠️ 응답 본문이 비어 있습니다. (상태 코드: \(statusCode))")
                    DispatchQueue.main.async { completion(statusCode) }
                    return
                }

                do {
                    let responseData = try JSONDecoder().decode(SignInResponse.self, from: result.data)
                    let accessToken = responseData.accessToken
                    let refreshToken = responseData.refreshToken
                    let role = responseData.role

                    let accessTokenExpiresIn: Double = {
                        let formatter = ISO8601DateFormatter()
                        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                        if let date = formatter.date(from: responseData.accessTokenExpiresIn) {
                            let timestamp = date.timeIntervalSince1970
                            print("✅ accessTokenExpiresIn 변환 성공: \(timestamp)")
                            return timestamp
                        } else {
                            print("❌ accessTokenExpiresIn 변환 실패")
                            return 0
                        }
                    }()

                    let refreshTokenExpiresIn: Double = {
                        let formatter = ISO8601DateFormatter()
                        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                        if let date = formatter.date(from: responseData.refreshTokenExpiresIn) {
                            let timestamp = date.timeIntervalSince1970
                            print("✅ refreshTokenExpiresIn 변환 성공: \(timestamp)")
                            return timestamp
                        } else {
                            print("❌ refreshTokenExpiresIn 변환 실패")
                            return 0
                        }
                    }()


                    KeyChain.shared.saveTokenWithExpiration(key: Const.KeyChainKey.accessToken, token: accessToken, expiresIn: accessTokenExpiresIn)
                    KeyChain.shared.saveTokenWithExpiration(key: Const.KeyChainKey.refreshToken, token: refreshToken, expiresIn: refreshTokenExpiresIn)

                    print("✅ 토큰 저장 완료!")

                    DispatchQueue.main.async {
                        switch statusCode {
                        case 200...299:
                            print("🎉 로그인 성공! (상태 코드: \(statusCode))")
                        case 400:
                            print("⚠️ [\(statusCode)] 잘못된 요청 - 입력값을 확인하세요.")
                        case 401:
                            print("🔑 [\(statusCode)] 인증 실패 - 로그인 정보를 확인하세요.")
                        case 403:
                            print("🚫 [\(statusCode)] 접근 금지 - 권한이 없습니다.")
                        case 500:
                            print("🔥 [\(statusCode)] 서버 오류 - 나중에 다시 시도하세요.")
                        default:
                            print("❓ 예상치 못한 상태 코드: \(statusCode), 응답 데이터: \(responseData)")
                        }
                        completion(statusCode)
                    }
                } catch {
                    print("❌ JSON 파싱 오류 발생 (상태 코드: \(statusCode)) - \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(-1)
                    }
                }

            case .failure(let err):
                print("🌐 네트워크 오류 발생! - \(err.localizedDescription)")
                DispatchQueue.main.async {
                    completion(0)
                }
            }
        }
    }
}
