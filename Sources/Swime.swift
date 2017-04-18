import Foundation

public struct Swime {
  /// File data
  let data: Data

  ///  A static method to get the `MimeType` that matches the given file data
  ///
  ///  - returns: Optional<MimeType>
  static public func mimeType(data: Data) -> MimeType? {
    return Swime(data: data).mimeType()
  }

  ///  A static method to get the `MimeType` that matches the given bytes
  ///
  ///  - returns: Optional<MimeType>
  static public func mimeType(bytes: [UInt8]) -> MimeType? {
    return Swime(bytes: bytes).mimeType()
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
  internal func readBytes(count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)

    data.copyBytes(to: &bytes, count: count)

    return bytes
  }
}
