// swift-tools-version:5.3
import PackageDescription
let package = Package(
  name: "TokamakApp",
  platforms: [.macOS(.v11)],
  products: [
    .executable(name: "TokamakApp", targets: ["TokamakApp"])
  ],
  dependencies: [
    .package(name: "Tokamak", url: "https://github.com/TokamakUI/Tokamak", from: "0.9.0"),
    .package(url: "https://github.com/NguyenPhongVN/vapor-composable-architecture.git", .branch("develop")),
  ],
  targets: [
    .target(
      name: "TokamakApp",
      dependencies: [
        .product(name: "TokamakShim", package: "Tokamak"),
        .product(name: "ComposableArchitecture", package: "vapor-composable-architecture")
      ],
      linkerSettings: [
        .unsafeFlags(["-Xfrontend", "-disable-availability-checking"])
      ]
    ),

    .testTarget(
      name: "TokamakAppTests",
      dependencies: ["TokamakApp"]),
  ]
)
