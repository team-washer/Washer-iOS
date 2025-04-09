//
//  DesignModifire.swift
//  Washer
//
//  Created by 서지완 on 3/15/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import SwiftUI

enum PretendardStyle: String {
    case black = "Pretendard-Black"
    case bold = "Pretendard-Bold"
    case extraBold = "Pretendard-ExtraBold"
    case extraLight = "Pretendard-ExtraLight"
    case light = "Pretendard-Light"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
    case semiBold = "Pretendard-SemiBold"
    case thin = "Pretendard-Thin"
}

extension Font {
    static func pretendard(_ style: PretendardStyle, size: CGFloat) -> Font {
        return .custom(style.rawValue, size: size)
    }
}

enum ColorStyle: String {
    case gray50 = "Gray50"
    case gray100 = "Gray100"
    case gray200 = "Gray200"
    case gray300 = "Gray300"
    case gray400 = "Gray400"
    case gray500 = "Gray500"
    case gray600 = "Gray600"
    case gray700 = "Gray700"
    case gray800 = "Gray800"
    case gray900 = "Gray900"
    case main100 = "main100"
    case main200 = "main200"
    case main300 = "main300"
    case main400 = "main400"
}

extension Color {
    static func color(_ style: ColorStyle) -> Color {
        return Color(style.rawValue)
    }
}

extension Text {
    func color(_ style: ColorStyle) -> Text {
        return self.foregroundColor(.color(style))
    }
}

extension View {
    func color(_ style: ColorStyle) -> some View {
        self.foregroundColor(.color(style))
    }
}

//MARK: 폰트, 컬러 사용 양식
struct DesignModifireView: View {
    var body: some View {
        Text("Hello, Pretendard!")
            .font(.pretendard(.semiBold, size: 20))
            .color(.gray600)
    }
}

#Preview {
    DesignModifireView()
}
