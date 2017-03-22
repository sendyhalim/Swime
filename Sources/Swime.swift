import Foundation

struct Swime {
  let data: Data

  public func mimeType() -> String {
    return "wut"
  }

  public func readBytes(count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)

    data.copyBytes(to: &bytes, count: count)

    return bytes
  }
}

