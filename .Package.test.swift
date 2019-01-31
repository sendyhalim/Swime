import PackageDescription

let package = Package(
  name: "Swime",
  dependencies: [
    .package(url: "https://github.com/Quick/Quick", majorVersion: 1),
    .package(url: "https://github.com/Quick/Nimble", majorVersion: 6)
  ]
)
