// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "Swime",
  platforms: [
    .iOS(.v9),
    .macOS(.v10_10)
  ],
  products: [
    .library(name: "Swime", targets: ["Swime"])
  ],
  dependencies: [
    .package(url: "https://github.com/Quick/Quick", from: "1.3.4"),
    .package(url: "https://github.com/Quick/Nimble", from: "7.3.3")
  ],
  targets: [
    .target(
      name: "Swime",
      path: "./Sources"
   ),
    .testTarget(
      name: "SwimeTests",
      dependencies: [
        "Swime",
        "Quick",
        "Nimble"
      ]
    )
  ]
)
