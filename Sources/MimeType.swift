import Foundation

/// List of mime type extension enum
/// with this enum we can check mime type with addition of swift type checker
/// ```
/// let swime = Swime(data: data)
/// swime.typeIs(.jpg)
/// ```
public enum MimeTypeExtension {
  case amr
  case ar
  case avi
  case bmp
  case bz2
  case cab
  case cr2
  case crx
  case deb
  case dmg
  case eot
  case epub
  case exe
  case flac
  case flif
  case flv
  case gif
  case gz
  case ico
  case jpg
  case jxr
  case lz
  case m4a
  case m4v
  case mid
  case mkv
  case mov
  case mp3
  case mp4
  case mpg
  case msi
  case mxf
  case nes
  case ogg
  case opus
  case otf
  case pdf
  case png
  case ps
  case psd
  case rar
  case rpm
  case rtf
  case sevenZ // 7z, Swift does not let us define enum that starts with a digit
  case sqlite
  case swf
  case tar
  case tif
  case ttf
  case wav
  case webm
  case webp
  case wmv
  case woff
  case woff2
  case xpi
  case xz
  case z
  case zip
}

public struct MimeType {
  /// Mime type string representation. For example "application/pdf"
  public let mime: String

  /// Mime type extension. For example "pdf"
  public let ext: String

  /// Mime type enum extension representation. For example `.pdf`
  public let extEnum: MimeTypeExtension

  /// Number of bytes required for `MimeType` to be able to check if the
  /// given bytes match with its mime type magic number specifications.
  fileprivate let bytesCount: Int

  /// A function to check if the bytes match the `MimeType` specifications.
  fileprivate let matches: ([UInt8], Swime) -> Bool

  ///  Check if the given bytes matches with `MimeType`
  ///  it will check for the `bytes.count` first before delegating the 
  ///  checker function to `matches` property
  ///
  ///  - parameter bytes: Bytes represented with `[UInt8]`
  ///  - parameter swime: Swime instance
  ///
  ///  - returns: Bool
  public func matches(bytes: [UInt8], swime: Swime) -> Bool {
    return bytes.count >= bytesCount && matches(bytes, swime)
  }

  /// List of all supported `MimeType`s
  public static let all: [MimeType] = [
    MimeType(
      mime: "image/jpeg",
      ext: "jpg",
      extEnum: .jpg,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0...2] == [0xFF, 0xD8, 0xFF]
      }
    ),
    MimeType(
      mime: "image/png",
      ext: "png",
      extEnum: .png,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x89, 0x50, 0x4E, 0x47]
      }
    ),
    MimeType(
      mime: "image/gif",
      ext: "gif",
      extEnum: .gif,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0...2] == [0x47, 0x49, 0x46]
      }
    ),
    MimeType(
      mime: "image/webp",
      ext: "webp",
      extEnum: .webp,
      bytesCount: 12,
      matches: { bytes, _ in
        return bytes[8...11] == [0x57, 0x45, 0x42, 0x50]
      }
    ),
    MimeType(
      mime: "image/flif",
      ext: "flif",
      extEnum: .flif,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x46, 0x4C, 0x49, 0x46]
      }
    ),
    MimeType(
      mime: "image/x-canon-cr2",
      ext: "cr2",
      extEnum: .cr2,
      bytesCount: 10,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x49, 0x49, 0x2A, 0x00] || bytes[0...3] == [0x4D, 0x4D, 0x00, 0x2A]) &&
          (bytes[8...9] == [0x43, 0x52])
      }
    ),
    MimeType(
      mime: "image/tiff",
      ext: "tif",
      extEnum: .tif,
      bytesCount: 4,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x49, 0x49, 0x2A, 0x00]) ||
          (bytes[0...3] == [0x4D, 0x4D, 0x20, 0x2A])
      }
    ),
    MimeType(
      mime: "image/bmp",
      ext: "bmp",
      extEnum: .bmp,
      bytesCount: 2,
      matches: { bytes, _ in
        return bytes[0...1] == [0x42, 0x4D]
      }
    ),
    MimeType(
      mime: "image/vnd.ms-photo",
      ext: "jxr",
      extEnum: .jxr,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0...2] == [0x49, 0x49, 0xBC]
      }
    ),
    MimeType(
      mime: "image/vnd.adobe.photoshop",
      ext: "psd",
      extEnum: .psd,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x38, 0x42, 0x50, 0x53]
      }
    ),
    MimeType(
      mime: "application/epub+zip",
      ext: "epub",
      extEnum: .epub,
      bytesCount: 58,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x50, 0x4B, 0x03, 0x04]) &&
          (bytes[30...57] == [
            0x6D, 0x69, 0x6D, 0x65, 0x74, 0x79, 0x70, 0x65, 0x61, 0x70, 0x70, 0x6C,
            0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x2F, 0x65, 0x70, 0x75, 0x62,
            0x2B, 0x7A, 0x69, 0x70
          ])
      }
    ),

    // Needs to be before `zip` check
    // assumes signed .xpi from addons.mozilla.org
    MimeType(
      mime: "application/x-xpinstall",
      ext: "xpi",
      extEnum: .xpi,
      bytesCount: 50,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x50, 0x4B, 0x03, 0x04]) &&
        (bytes[30...49] == [
          0x4D, 0x45, 0x54, 0x41, 0x2D, 0x49, 0x4E, 0x46, 0x2F, 0x6D, 0x6F, 0x7A,
          0x69, 0x6C, 0x6C, 0x61, 0x2E, 0x72, 0x73, 0x61
        ])
      }
    ),
    MimeType(
      mime: "application/zip",
      ext: "zip",
      extEnum: .zip,
      bytesCount: 50,
      matches: { bytes, _ in
        return (bytes[0...1] == [0x50, 0x4B]) &&
          (bytes[2] == 0x3 || bytes[2] == 0x5 || bytes[2] == 0x7) &&
          (bytes[3] == 0x4 || bytes[3] == 0x6 || bytes[3] == 0x8)
      }
    ),
    MimeType(
      mime: "application/x-tar",
      ext: "tar",
      extEnum: .tar,
      bytesCount: 262,
      matches: { bytes, _ in
        return bytes[257...261] == [0x75, 0x73, 0x74, 0x61, 0x72]
      }
    ),
    MimeType(
      mime: "application/x-rar-compressed",
      ext: "rar",
      extEnum: .rar,
      bytesCount: 7,
      matches: { bytes, _ in
        return (bytes[0...5] == [0x52, 0x61, 0x72, 0x21, 0x1A, 0x07]) &&
          (bytes[6] == 0x0 || bytes[6] == 0x1)
      }
    ),
    MimeType(
      mime: "application/gzip",
      ext: "gz",
      extEnum: .gz,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0...2] == [0x1F, 0x8B, 0x08]
      }
    ),
    MimeType(
      mime: "application/x-bzip2",
      ext: "bz2",
      extEnum: .bz2,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0...2] == [0x42, 0x5A, 0x68]
      }
    ),
    MimeType(
      mime: "application/x-7z-compressed",
      ext: "7z",
      extEnum: .sevenZ,
      bytesCount: 6,
      matches: { bytes, _ in
        return bytes[0...5] == [0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C]
      }
    ),
    MimeType(
      mime: "application/x-apple-diskimage",
      ext: "dmg",
      extEnum: .dmg,
      bytesCount: 2,
      matches: { bytes, _ in
        return bytes[0...1] == [0x78, 0x01]
      }
    ),
    MimeType(
      mime: "video/mp4",
      ext: "mp4",
      extEnum: .mp4,
      bytesCount: 28,
      matches: { bytes, _ in
        return (bytes[0...2] == [0x00, 0x00, 0x00] && (bytes[3] == 0x18 || bytes[3] == 0x20) && bytes[4...7] == [0x66, 0x74, 0x79, 0x70]) ||
          (bytes[0...3] == [0x33, 0x67, 0x70, 0x35]) ||
          (bytes[0...11] == [0x00, 0x00, 0x00, 0x1C, 0x66, 0x74, 0x79, 0x70, 0x6D, 0x70, 0x34, 0x32] &&
            bytes[16...27] == [0x6D, 0x70, 0x34, 0x31, 0x6D, 0x70, 0x34, 0x32, 0x69, 0x73, 0x6F, 0x6D]) ||
          (bytes[0...11] == [0x00, 0x00, 0x00, 0x1C, 0x66, 0x74, 0x79, 0x70, 0x69, 0x73, 0x6F, 0x6D]) ||
          (bytes[0...11] == [0x00, 0x00, 0x00, 0x1C, 0x66, 0x74, 0x79, 0x70, 0x6D, 0x70, 0x34, 0x32, 0x00, 0x00, 0x00, 0x00])
      }
    ),
    MimeType(
      mime: "video/x-m4v",
      ext: "m4v",
      extEnum: .m4v,
      bytesCount: 11,
      matches: { bytes, _ in
        return bytes[0...10] == [0x00, 0x00, 0x00, 0x1C, 0x66, 0x74, 0x79, 0x70, 0x4D, 0x34, 0x56]
      }
    ),
    MimeType(
      mime: "audio/midi",
      ext: "mid",
      extEnum: .mid,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x4D, 0x54, 0x68, 0x64]
      }
    ),
    MimeType(
      mime: "video/x-matroska",
      ext: "mkv",
      extEnum: .mkv,
      bytesCount: 4,
      matches: { bytes, swime in
        guard bytes[0...3] == [0x1A, 0x45, 0xDF, 0xA3] else {
          return false
        }

        let _bytes = Array(swime.readBytes(count: 4100)[4 ..< 4100])
        var idPos = -1

        for i in 0 ..< (_bytes.count - 1) {
          if _bytes[i] == 0x42 && _bytes[i + 1] == 0x82 {
            idPos = i
            break;
          }
        }

        guard idPos > -1 else {
          return false
        }

        let docTypePos = idPos + 3
        let findDocType: (String) -> Bool = { type in
          for i in 0 ..< type.characters.count {
            let index = type.characters.index(type.startIndex, offsetBy: i)
            let scalars = String(type.characters[index]).unicodeScalars

            if _bytes[docTypePos + i] != UInt8(scalars[scalars.startIndex].value) {
              return false
            }
          }

          return true
        }

        return findDocType("matroska")
      }
    ),
    MimeType(
      mime: "video/webm",
      ext: "webm",
      extEnum: .webm,
      bytesCount: 4,
      matches: { bytes, swime in
        guard bytes[0...3] == [0x1A, 0x45, 0xDF, 0xA3] else {
          return false
        }

        let _bytes = Array(swime.readBytes(count: 4100)[4 ..< 4100])
        var idPos = -1

        for i in 0 ..< (_bytes.count - 1) {
          if _bytes[i] == 0x42 && _bytes[i + 1] == 0x82 {
            idPos = i
            break;
          }
        }

        guard idPos > -1 else {
          return false
        }

        let docTypePos = idPos + 3
        let findDocType: (String) -> Bool = { type in
          for i in 0 ..< type.characters.count {
            let index = type.characters.index(type.startIndex, offsetBy: i)
            let scalars = String(type.characters[index]).unicodeScalars

            if _bytes[docTypePos + i] != UInt8(scalars[scalars.startIndex].value) {
              return false
            }
          }

          return true
        }

        return findDocType("webm")
      }
    ),
    MimeType(
      mime: "video/quicktime",
      ext: "mov",
      extEnum: .mov,
      bytesCount: 8,
      matches: { bytes, _ in
        return bytes[0...7] == [0x00, 0x00, 0x00, 0x14, 0x66, 0x74, 0x79, 0x70]
      }
    ),
    MimeType(
      mime: "video/x-msvideo",
      ext: "avi",
      extEnum: .avi,
      bytesCount: 11,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x52, 0x49, 0x46, 0x46]) &&
          (bytes[8...10] == [0x41, 0x56, 0x49])
      }
    ),
    MimeType(
      mime: "video/x-ms-wmv",
      ext: "wmv",
      extEnum: .wmv,
      bytesCount: 10,
      matches: { bytes, _ in
        return bytes[0...9] == [0x30, 0x26, 0xB2, 0x75, 0x8E, 0x66, 0xCF, 0x11, 0xA6, 0xD9]
      }
    ),
    MimeType(
      mime: "video/mpeg",
      ext: "mpg",
      extEnum: .mpg,
      bytesCount: 4,
      matches: { bytes, _ in
        guard bytes[0...2] == [0x00, 0x00, 0x01]  else {
          return false
        }

        let hexCode = String(format: "%2X", bytes[3])

        return hexCode.characters.first != nil && hexCode.characters.first! == "B"
      }
    ),
    MimeType(
      mime: "audio/mpeg",
      ext: "mp3",
      extEnum: .mp3,
      bytesCount: 3,
      matches: { bytes, _ in
        return (bytes[0...2] == [0x49, 0x44, 0x33]) ||
          (bytes[0...1] == [0xFF, 0xFB])
      }
    ),
    MimeType(
      mime: "audio/m4a",
      ext: "m4a",
      extEnum: .m4a,
      bytesCount: 11,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x4D, 0x34, 0x41, 0x20]) ||
          (bytes[4...10] == [0x66, 0x74, 0x79, 0x70, 0x4D, 0x34, 0x41])
      }
    ),

    // Needs to be before `ogg` check
    MimeType(
      mime: "audio/opus",
      ext: "opus",
      extEnum: .opus,
      bytesCount: 36,
      matches: { bytes, _ in
        return bytes[28...35] == [0x4F, 0x70, 0x75, 0x73, 0x48, 0x65, 0x61, 0x64]
      }
    ),
    MimeType(
      mime: "audio/ogg",
      ext: "ogg",
      extEnum: .ogg,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x4F, 0x67, 0x67, 0x53]
      }
    ),
    MimeType(
      mime: "audio/x-flac",
      ext: "flac",
      extEnum: .flac,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x66, 0x4C, 0x61, 0x43]
      }
    ),
    MimeType(
      mime: "audio/x-wav",
      ext: "wav",
      extEnum: .wav,
      bytesCount: 12,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x52, 0x49, 0x46, 0x46]) &&
          (bytes[8...11] == [0x57, 0x41, 0x56, 0x45])
      }
    ),
    MimeType(
      mime: "audio/amr",
      ext: "amr",
      extEnum: .amr,
      bytesCount: 6,
      matches: { bytes, _ in
        return bytes[0...5] == [0x23, 0x21, 0x41, 0x4D, 0x52, 0x0A]
      }
    ),
    MimeType(
      mime: "application/pdf",
      ext: "pdf",
      extEnum: .pdf,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x25, 0x50, 0x44, 0x46]
      }
    ),
    MimeType(
      mime: "application/x-msdownload",
      ext: "exe",
      extEnum: .exe,
      bytesCount: 2,
      matches: { bytes, _ in
        return bytes[0...1] == [0x4D, 0x5A]
      }
    ),
    MimeType(
      mime: "application/x-shockwave-flash",
      ext: "swf",
      extEnum: .swf,
      bytesCount: 3,
      matches: { bytes, _ in
        return (bytes[0] == 0x43 || bytes[0] == 0x46) && (bytes[1...2] == [0x57, 0x53])
      }
    ),
    MimeType(
      mime: "application/rtf",
      ext: "rtf",
      extEnum: .rtf,
      bytesCount: 5,
      matches: { bytes, _ in
        return bytes[0...4] == [0x7B, 0x5C, 0x72, 0x74, 0x66]
      }
    ),
    MimeType(
      mime: "application/font-woff",
      ext: "woff",
      extEnum: .woff,
      bytesCount: 8,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x77, 0x4F, 0x46, 0x46]) &&
          ((bytes[4...7] == [0x00, 0x01, 0x00, 0x00]) || (bytes[4...7] == [0x4F, 0x54, 0x54, 0x4F]))
      }
    ),
    MimeType(
      mime: "application/font-woff",
      ext: "woff2",
      extEnum: .woff2,
      bytesCount: 8,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x77, 0x4F, 0x46,  0x32]) &&
          ((bytes[4...7] == [0x00, 0x01, 0x00, 0x00]) || (bytes[4...7] == [0x4F, 0x54, 0x54, 0x4F]))
      }
    ),
    MimeType(
      mime: "application/octet-stream",
      ext: "eot",
      extEnum: .eot,
      bytesCount: 11,
      matches: { bytes, _ in
        return (bytes[34...35] == [0x4C, 0x50]) &&
          ((bytes[8...10] == [0x00, 0x00, 0x01]) || (bytes[8...10] == [0x01, 0x00, 0x02]) || (bytes[8...10] == [0x02, 0x00, 0x02]))
      }
    ),
    MimeType(
      mime: "application/font-sfnt",
      ext: "ttf",
      extEnum: .ttf,
      bytesCount: 5,
      matches: { bytes, _ in
        return bytes[0...4] == [0x00, 0x01, 0x00, 0x00, 0x00]
      }
    ),
    MimeType(
      mime: "application/font-sfnt",
      ext: "otf",
      extEnum: .otf,
      bytesCount: 5,
      matches: { bytes, _ in
        return bytes[0...4] == [0x4F, 0x54, 0x54, 0x4F, 0x00]
      }
    ),
    MimeType(
      mime: "image/x-icon",
      ext: "ico",
      extEnum: .ico,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x00, 0x00, 0x01, 0x00]
      }
    ),
    MimeType(
      mime: "video/x-flv",
      ext: "flv",
      extEnum: .flv,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x46, 0x4C, 0x56, 0x01]
      }
    ),
    MimeType(
      mime: "application/postscript",
      ext: "ps",
      extEnum: .ps,
      bytesCount: 2,
      matches: { bytes, _ in
        return bytes[0...1] == [0x25, 0x21]
      }
    ),
    MimeType(
      mime: "application/x-xz",
      ext: "xz",
      extEnum: .xz,
      bytesCount: 6,
      matches: { bytes, _ in
        return bytes[0...5] == [0xFD, 0x37, 0x7A, 0x58, 0x5A, 0x00]
      }
    ),
    MimeType(
      mime: "application/x-sqlite3",
      ext: "sqlite",
      extEnum: .sqlite,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x53, 0x51, 0x4C, 0x69]
      }
    ),
    MimeType(
      mime: "application/x-nintendo-nes-rom",
      ext: "nes",
      extEnum: .nes,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x4E, 0x45, 0x53, 0x1A]
      }
    ),
    MimeType(
      mime: "application/x-google-chrome-extension",
      ext: "crx",
      extEnum: .crx,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x43, 0x72, 0x32, 0x34]
      }
    ),
    MimeType(
      mime: "application/vnd.ms-cab-compressed",
      ext: "cab",
      extEnum: .cab,
      bytesCount: 4,
      matches: { bytes, _ in
        return (bytes[0...3] == [0x4D, 0x53, 0x43, 0x46]) || (bytes[0...3] == [0x49, 0x53, 0x63, 0x28])
      }
    ),

    // Needs to be before `ar` check
    MimeType(
      mime: "application/x-deb",
      ext: "deb",
      extEnum: .deb,
      bytesCount: 21,
      matches: { bytes, _ in
        return bytes[0...20] == [
          0x21, 0x3C, 0x61, 0x72, 0x63, 0x68, 0x3E, 0x0A, 0x64, 0x65, 0x62, 0x69,
          0x61, 0x6E, 0x2D, 0x62, 0x69, 0x6E, 0x61, 0x72, 0x79
        ]
      }
    ),
    MimeType(
      mime: "application/x-unix-archive",
      ext: "ar",
      extEnum: .ar,
      bytesCount: 7,
      matches: { bytes, _ in
        return bytes[0...6] == [0x21, 0x3C, 0x61, 0x72, 0x63, 0x68, 0x3E]
      }
    ),
    MimeType(
      mime: "application/x-rpm",
      ext: "rpm",
      extEnum: .rpm,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0xED, 0xAB, 0xEE, 0xDB]
      }
    ),
    MimeType(
      mime: "application/x-compress",
      ext: "Z",
      extEnum: .z,
      bytesCount: 2,
      matches: { bytes, _ in
        return (bytes[0...1] == [0x1F, 0xA0]) || (bytes[0...1] == [0x1F, 0x9D])
      }
    ),
    MimeType(
      mime: "application/x-lzip",
      ext: "lz",
      extEnum: .lz,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0...3] == [0x4C, 0x5A, 0x49, 0x50]
      }
    ),
    MimeType(
      mime: "application/x-msi",
      ext: "msi",
      extEnum: .msi,
      bytesCount: 8,
      matches: { bytes, _ in
        return bytes[0...7] == [0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1]
      }
    ),
    MimeType(
      mime: "application/mxf",
      ext: "mxf",
      extEnum: .mxf,
      bytesCount: 14,
      matches: { bytes, _ in
        return bytes[0...13] == [0x06, 0x0E, 0x2B, 0x34, 0x02, 0x05, 0x01, 0x01, 0x0D, 0x01, 0x02, 0x01, 0x01, 0x02 ]
      }
    )
  ]
}
