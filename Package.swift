// swift-tools-version:5.9
import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSetting = PackageSettings(
    baseSettings: .settings(
        configurations: [
            .debug(name: .dev),
            .debug(name: .stage),
            .release(name: .prod)
        ]
    )
)
#endif

let package = Package(
    name: "Package",
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0")
    ]
)
