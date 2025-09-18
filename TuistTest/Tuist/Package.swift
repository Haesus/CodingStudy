// swift-tools-version: 5.9
import PackageDescription
#if TUIST
import ProjectDescription
let packageSettings = PackageSettings() // 필요시 productTypes 오버라이드
#endif

let package = Package(
  name: "SwiftPackageManager",
  dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire", from: "5.10.0"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
    .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0"))
  ]
)
