import Foundation

public struct Swime {
  /// File data
  let data: Data

  ///  Optional computed property of mime type extension enum.
  ///  ```
  ///  swime.type == .jpg
  ///  ```
  public var type: MimeTypeExtension? {
    return mimeType()?.extEnum
  }

  public init(data: Data) {
    self.data = data
  }

  public init(bytes: [UInt8]) {
    self.init(data: Data(bytes: bytes))
  }

  ///  Get the `MimeType` that matches the file data
  ///
  ///  - returns: Optional<MimeType>
  public func mimeType() -> MimeType? {
    let bytes = readBytes(count: 262)

    for mime in MimeType.all {
      if mime.matches(bytes: bytes, swime: self) {
        return mime
      }
    }

    return nil
  }

  ///  Read bytes from file data
  ///
  ///  - parameter count: Number of bytes to be read
  ///
  ///  - returns: Bytes represented with `[UInt8]`
  public func readBytes(count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)

    data.copyBytes(to: &bytes, count: count)

    return bytes
  }
}
