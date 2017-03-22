import Foundation

public struct Swime {
  let data: Data

  public func mimeType() -> MimeType? {
    let bytes = readBytes(count: 57)

    for (_, mimeType) in MimeType.specifications {
      if bytes == mimeType.magicNumbers {
        return mimeType
      }
    }

    return nil
  }

  public func readBytes(count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)

    data.copyBytes(to: &bytes, count: count)

    return bytes
  }
}

