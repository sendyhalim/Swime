# Swime
Detect mime type of a `Data` using Swift, ported from [sindresorhus/file-type](https://github.com/sindresorhus/file-type)

[![Build Status](https://travis-ci.org/sendyhalim/Swime.svg?branch=master)](https://travis-ci.org/sendyhalim/Swime)

## Installation
### Swift Package Manager
```swift
import PackageDescription

let package = Package(
  name: "MyApp",
  dependencies: [
    .Package(url: "https://github.com/sendyhalim/Swime", majorVersion: 1)
  ]
)
```

## Usage
```swift
import Swime

let projectDir = FileManager.default.currentDirectoryPath
let path = "/path/to/some-file.jpg"
let url = URL(fileURLWithPath: path, isDirectory: false)
let data = try! Data(contentsOf: url)
let swime = Swime(data: data)

swime.mimeType()! // MimeType(ext: "wmv", mime: "video/x-ms-wmv")
```
## Testing

```
make test
```
