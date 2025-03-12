import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

@MainActor
public extension TargetDependency.SPM {
    static let Moya = TargetDependency.external(name: "Moya")
}

public extension Package {
}
