import Foundation

public struct Swime {
  let data: Data

  public func mimeType() -> MimeType? {
    let bytes = readBytes(count: 57)

    for (_, mimeType) in MimeType.specifications {
      let bytesToCompare = Array(bytes[0 ..< mimeType.magicNumbers.count])

      if bytesToCompare == mimeType.magicNumbers {
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

