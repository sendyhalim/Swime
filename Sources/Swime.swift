import Foundation

public struct Swime {
  let data: Data

  public init(data: Data) {
    self.data = data
  }

  public func mimeType() -> MimeType? {
    let bytes = readBytes(count: 262)

    for mime in MimeType.all {
      if mime.matches(bytes: bytes, swime: self) {
        return mime
      }
    }

    return nil
  }

  public func readBytes(count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)

    data.copyBytes(to: &bytes, count: count)

    return bytes
  }

  public func typeIs(_ ext: MimeTypeExtension) -> Bool {
    return mimeType()?.extEnum == Optional.some(ext)
  }
}

