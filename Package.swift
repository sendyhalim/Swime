// swift-tools-version:4.2
import PackageDescription

let package = Package(
  name: "Swime",
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
