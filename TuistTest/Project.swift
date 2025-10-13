// Project.swift (정상 동작 버전: Tuist 4.68.0)
import ProjectDescription

let project = Project(
    name: "TuistSwiftUI",
    options: .options(developmentRegion: "ko"),
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.22.3")),
        .remote(url: "https://github.com/pointfreeco/swift-case-paths", requirement: .upToNextMajor(from: "1.3.0")),
    ],
    settings: .settings(
        base: [
            "IPHONEOS_DEPLOYMENT_TARGET": "16.0",
            "SWIFT_VERSION": "5.0",
            "PRODUCT_NAME": "TuistSwiftUIApp"
        ]
    ),
    targets: [
        .target(
            name: "TuistSwiftUIApp",
            destinations: .iOS,
            product: .app,
            bundleId: "Haesus.com.github.tuistswiftui",
            infoPlist: .extendingDefault(with: [:]),
            sources: ["App/Sources/**"],
            resources: ["App/Resources/**"],
            entitlements: .file(path: "App/TuistSwiftUI.entitlements"),
            dependencies: [
                .external(name: "Alamofire"),
                .external(name: "RxSwift"),
                .external(name: "ReactorKit"),
                .package(product: "ComposableArchitecture", type: .runtime),
                .package(product: "CasePaths", type: .runtime),

                // Macros (compile-time)
                .package(product: "ComposableArchitectureMacros", type: .macro),
                .package(product: "CasePathsMacros", type: .macro),
            ],
            settings: .settings(base: [
                "DEVELOPMENT_TEAM": "3TGR3P459K",
                "CODE_SIGN_STYLE": "Automatic",
                "INFOPLIST_KEY_CFBundleDisplayName": "TCA 연습",
                "PRODUCT_NAME": "TCA_학습",
                "MARKETING_VERSION": "1.0.0",
                "CURRENT_PROJECT_VERSION": "42"
                // 필요하면 아래도 추가 가능:
                // "CODE_SIGN_IDENTITY": "Apple Development",
                // "PROVISIONING_PROFILE_SPECIFIER": ""
            ])
        )
    ]
)
