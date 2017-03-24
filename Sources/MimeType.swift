import Foundation

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
  public let mime: String
  public let ext: String
  public let extEnum: MimeTypeExtension

  fileprivate let bytesCount: Int
  fileprivate let matches: ([UInt8], Swime) -> Bool

  public func matches(bytes: [UInt8], swime: Swime) -> Bool {
    return bytes.count >= bytesCount && matches(bytes, swime)
  }

  static let all: [MimeType] = [
    MimeType(
      mime: "image/jpeg",
      ext: "jpg",
      extEnum: .jpg,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF
      }
    ),
    MimeType(
      mime: "image/png",
      ext: "png",
      extEnum: .png,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x89 && bytes[1] == 0x50 && bytes[2] == 0x4E && bytes[3] == 0x47
      }
    ),
    MimeType(
      mime: "image/gif",
      ext: "gif",
      extEnum: .gif,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0] == 0x47 && bytes[1] == 0x49 && bytes[2] == 0x46
      }
    ),
    MimeType(
      mime: "image/webp",
      ext: "webp",
      extEnum: .webp,
      bytesCount: 12,
      matches: { bytes, _ in
        return bytes[8] == 0x57 && bytes[9] == 0x45 && bytes[10] == 0x42 && bytes[11] == 0x50
      }
    ),
    MimeType(
      mime: "image/flif",
      ext: "flif",
      extEnum: .flif,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x46 && bytes[1] == 0x4C && bytes[2] == 0x49 && bytes[3] == 0x46
      }
    ),
    MimeType(
      mime: "image/x-canon-cr2",
      ext: "cr2",
      extEnum: .cr2,
      bytesCount: 10,
      matches: { bytes, _ in
        return ((bytes[0] == 0x49 && bytes[1] == 0x49 && bytes[2] == 0x2A && bytes[3] == 0x0) ||
          (bytes[0] == 0x4D && bytes[1] == 0x4D && bytes[2] == 0x0 && bytes[3] == 0x2A)) &&
          (bytes[8] == 0x43 && bytes[9] == 0x52)
      }
    ),
    MimeType(
      mime: "image/tiff",
      ext: "tif",
      extEnum: .tif,
      bytesCount: 4,
      matches: { bytes, _ in
        return (bytes[0] == 0x49 && bytes[1] == 0x49 && bytes[2] == 0x2A && bytes[3] == 0x0) ||
          (bytes[0] == 0x4D && bytes[1] == 0x4D && bytes[2] == 0x0 && bytes[3] == 0x2A)
      }
    ),
    MimeType(
      mime: "image/bmp",
      ext: "bmp",
      extEnum: .bmp,
      bytesCount: 2,
      matches: { bytes, _ in
        return bytes[0] == 0x42 && bytes[1] == 0x4D
      }
    ),
    MimeType(
      mime: "image/vnd.ms-photo",
      ext: "jxr",
      extEnum: .jxr,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0] == 0x49 && bytes[1] == 0x49 && bytes[2] == 0xBC
      }
    ),
    MimeType(
      mime: "image/vnd.adobe.photoshop",
      ext: "psd",
      extEnum: .psd,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x38 && bytes[1] == 0x42 && bytes[2] == 0x50 && bytes[3] == 0x53
      }
    ),
    MimeType(
      mime: "application/epub+zip",
      ext: "epub",
      extEnum: .epub,
      bytesCount: 58,
      matches: { bytes, _ in
        return bytes[0] == 0x50 && bytes[1] == 0x4B && bytes[2] == 0x3 && bytes[3] == 0x4 &&
          bytes[30] == 0x6D && bytes[31] == 0x69 && bytes[32] == 0x6D && bytes[33] == 0x65 &&
          bytes[34] == 0x74 && bytes[35] == 0x79 && bytes[36] == 0x70 && bytes[37] == 0x65 &&
          bytes[38] == 0x61 && bytes[39] == 0x70 && bytes[40] == 0x70 && bytes[41] == 0x6C &&
          bytes[42] == 0x69 && bytes[43] == 0x63 && bytes[44] == 0x61 && bytes[45] == 0x74 &&
          bytes[46] == 0x69 && bytes[47] == 0x6F && bytes[48] == 0x6E && bytes[49] == 0x2F &&
          bytes[50] == 0x65 && bytes[51] == 0x70 && bytes[52] == 0x75 && bytes[53] == 0x62 &&
          bytes[54] == 0x2B && bytes[55] == 0x7A && bytes[56] == 0x69 && bytes[57] == 0x70
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
        return bytes[0] == 0x50 && bytes[1] == 0x4B && bytes[2] == 0x3 && bytes[3] == 0x4 &&
          bytes[30] == 0x4D && bytes[31] == 0x45 && bytes[32] == 0x54 && bytes[33] == 0x41 &&
          bytes[34] == 0x2D && bytes[35] == 0x49 && bytes[36] == 0x4E && bytes[37] == 0x46 &&
          bytes[38] == 0x2F && bytes[39] == 0x6D && bytes[40] == 0x6F && bytes[41] == 0x7A &&
          bytes[42] == 0x69 && bytes[43] == 0x6C && bytes[44] == 0x6C && bytes[45] == 0x61 &&
          bytes[46] == 0x2E && bytes[47] == 0x72 && bytes[48] == 0x73 && bytes[49] == 0x61
      }
    ),
    MimeType(
      mime: "application/zip",
      ext: "zip",
      extEnum: .zip,
      bytesCount: 50,
      matches: { bytes, _ in
        return bytes[0] == 0x50 && bytes[1] == 0x4B &&
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
        return bytes[257] == 0x75 && bytes[258] == 0x73 && bytes[259] == 0x74 && bytes[260] == 0x61 && bytes[261] == 0x72
      }
    ),
    MimeType(
      mime: "application/x-rar-compressed",
      ext: "rar",
      extEnum: .rar,
      bytesCount: 7,
      matches: { bytes, _ in
        return bytes[0] == 0x52 && bytes[1] == 0x61 && bytes[2] == 0x72 && bytes[3] == 0x21 && bytes[4] == 0x1A && bytes[5] == 0x7 &&
          (bytes[6] == 0x0 || bytes[6] == 0x1)
      }
    ),
    MimeType(
      mime: "application/gzip",
      ext: "gz",
      extEnum: .gz,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0] == 0x1F && bytes[1] == 0x8B && bytes[2] == 0x8
      }
    ),
    MimeType(
      mime: "application/x-bzip2",
      ext: "bz2",
      extEnum: .bz2,
      bytesCount: 3,
      matches: { bytes, _ in
        return bytes[0] == 0x42 && bytes[1] == 0x5A && bytes[2] == 0x68
      }
    ),
    MimeType(
      mime: "application/x-7z-compressed",
      ext: "7z",
      extEnum: .sevenZ,
      bytesCount: 6,
      matches: { bytes, _ in
        return bytes[0] == 0x37 && bytes[1] == 0x7A && bytes[2] == 0xBC && bytes[3] == 0xAF && bytes[4] == 0x27 && bytes[5] == 0x1C
      }
    ),
    MimeType(
      mime: "application/x-apple-diskimage",
      ext: "dmg",
      extEnum: .dmg,
      bytesCount: 2,
      matches: { bytes, _ in
        return bytes[0] == 0x78 && bytes[1] == 0x01
      }
    ),
    MimeType(
      mime: "video/mp4",
      ext: "mp4",
      extEnum: .mp4,
      bytesCount: 28,
      matches: { bytes, _ in
        return (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && (bytes[3] == 0x18 || bytes[3] == 0x20) && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70) ||
          (bytes[0] == 0x33 && bytes[1] == 0x67 && bytes[2] == 0x70 && bytes[3] == 0x35) ||
          (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x1C && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x6D && bytes[9] == 0x70 && bytes[10] == 0x34 && bytes[11] == 0x32 && bytes[16] == 0x6D && bytes[17] == 0x70 && bytes[18] == 0x34 && bytes[19] == 0x31 && bytes[20] == 0x6D && bytes[21] == 0x70 && bytes[22] == 0x34 && bytes[23] == 0x32 && bytes[24] == 0x69 && bytes[25] == 0x73 && bytes[26] == 0x6F && bytes[27] == 0x6D) ||
          (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x1C && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x69 && bytes[9] == 0x73 && bytes[10] == 0x6F && bytes[11] == 0x6D) ||
          (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x1c && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x6D && bytes[9] == 0x70 && bytes[10] == 0x34 && bytes[11] == 0x32 && bytes[12] == 0x0 && bytes[13] == 0x0 && bytes[14] == 0x0 && bytes[15] == 0x0)
      }
    ),
    MimeType(
      mime: "video/x-m4v",
      ext: "m4v",
      extEnum: .m4v,
      bytesCount: 2,
      matches: { bytes, _ in
        return (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x1C && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x4D && bytes[9] == 0x34 && bytes[10] == 0x56)
      }
    ),
    MimeType(
      mime: "audio/midi",
      ext: "mid",
      extEnum: .mid,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x4D && bytes[1] == 0x54 && bytes[2] == 0x68 && bytes[3] == 0x64
      }
    ),
    MimeType(
      mime: "video/x-matroska",
      ext: "mkv",
      extEnum: .mkv,
      bytesCount: 4,
      matches: { bytes, swime in
        guard bytes[0] == 0x1A && bytes[1] == 0x45 && bytes[2] == 0xDF && bytes[3] == 0xA3 else {
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
        guard bytes[0] == 0x1A && bytes[1] == 0x45 && bytes[2] == 0xDF && bytes[3] == 0xA3 else {
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
        return bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x14 && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70
      }
    ),
    MimeType(
      mime: "video/x-msvideo",
      ext: "avi",
      extEnum: .avi,
      bytesCount: 11,
      matches: { bytes, _ in
        return bytes[0] == 0x52 && bytes[1] == 0x49 && bytes[2] == 0x46 && bytes[3] == 0x46 && bytes[8] == 0x41 && bytes[9] == 0x56 && bytes[10] == 0x49
      }
    ),
    MimeType(
      mime: "video/x-ms-wmv",
      ext: "wmv",
      extEnum: .wmv,
      bytesCount: 10,
      matches: { bytes, _ in
        return bytes[0] == 0x30 && bytes[1] == 0x26 && bytes[2] == 0xB2 && bytes[3] == 0x75 && bytes[4] == 0x8E && bytes[5] == 0x66 && bytes[6] == 0xCF && bytes[7] == 0x11 && bytes[8] == 0xA6 && bytes[9] == 0xD9
      }
    ),
    MimeType(
      mime: "video/mpeg",
      ext: "mpg",
      extEnum: .mpg,
      bytesCount: 4,
      matches: { bytes, _ in
        guard bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x1 else {
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
        return (bytes[0] == 0x49 && bytes[1] == 0x44 && bytes[2] == 0x33) ||
          (bytes[0] == 0xFF && bytes[1] == 0xfb)
      }
    ),
    MimeType(
      mime: "audio/m4a",
      ext: "m4a",
      extEnum: .m4a,
      bytesCount: 11,
      matches: { bytes, _ in
        return (bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x4D && bytes[9] == 0x34 && bytes[10] == 0x41) ||
          (bytes[0] == 0x4D && bytes[1] == 0x34 && bytes[2] == 0x41 && bytes[3] == 0x20)
      }
    ),

    // Needs to be before `ogg` check
    MimeType(
      mime: "audio/opus",
      ext: "opus",
      extEnum: .opus,
      bytesCount: 36,
      matches: { bytes, _ in
        return bytes[28] == 0x4F && bytes[29] == 0x70 && bytes[30] == 0x75 && bytes[31] == 0x73 && bytes[32] == 0x48 && bytes[33] == 0x65 && bytes[34] == 0x61 && bytes[35] == 0x64
      }
    ),
    MimeType(
      mime: "audio/ogg",
      ext: "ogg",
      extEnum: .ogg,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x4F && bytes[1] == 0x67 && bytes[2] == 0x67 && bytes[3] == 0x53
      }
    ),
    MimeType(
      mime: "audio/x-flac",
      ext: "flac",
      extEnum: .flac,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x66 && bytes[1] == 0x4C && bytes[2] == 0x61 && bytes[3] == 0x43
      }
    ),
    MimeType(
      mime: "audio/x-wav",
      ext: "wav",
      extEnum: .wav,
      bytesCount: 12,
      matches: { bytes, _ in
        return bytes[0] == 0x52 && bytes[1] == 0x49 && bytes[2] == 0x46 && bytes[3] == 0x46 && bytes[8] == 0x57 && bytes[9] == 0x41 && bytes[10] == 0x56 && bytes[11] == 0x45
      }
    ),
    MimeType(
      mime: "audio/amr",
      ext: "amr",
      extEnum: .amr,
      bytesCount: 12,
      matches: { bytes, _ in
        return bytes[0] == 0x23 && bytes[1] == 0x21 && bytes[2] == 0x41 && bytes[3] == 0x4D && bytes[4] == 0x52 && bytes[5] == 0x0A
      }
    ),
    MimeType(
      mime: "application/pdf",
      ext: "pdf",
      extEnum: .pdf,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x25 && bytes[1] == 0x50 && bytes[2] == 0x44 && bytes[3] == 0x46
      }
    ),
    MimeType(
      mime: "application/x-msdownload",
      ext: "exe",
      extEnum: .exe,
      bytesCount: 2,
      matches: { bytes, _ in
        return bytes[0] == 0x4D && bytes[1] == 0x5A
      }
    ),
    MimeType(
      mime: "application/x-shockwave-flash",
      ext: "swf",
      extEnum: .swf,
      bytesCount: 3,
      matches: { bytes, _ in
        return (bytes[0] == 0x43 || bytes[0] == 0x46) && bytes[1] == 0x57 && bytes[2] == 0x53
      }
    ),
    MimeType(
      mime: "application/rtf",
      ext: "rtf",
      extEnum: .rtf,
      bytesCount: 5,
      matches: { bytes, _ in
        return bytes[0] == 0x7B && bytes[1] == 0x5C && bytes[2] == 0x72 && bytes[3] == 0x74 && bytes[4] == 0x66
      }
    ),
    MimeType(
      mime: "application/font-woff",
      ext: "woff",
      extEnum: .woff,
      bytesCount: 8,
      matches: { bytes, _ in
        return (bytes[0] == 0x77 && bytes[1] == 0x4F && bytes[2] == 0x46 && bytes[3] == 0x46) &&
          ((bytes[4] == 0x00 && bytes[5] == 0x01 && bytes[6] == 0x00 && bytes[7] == 0x00) ||
          (bytes[4] == 0x4F && bytes[5] == 0x54 && bytes[6] == 0x54 && bytes[7] == 0x4F))
      }
    ),
    MimeType(
      mime: "application/font-woff",
      ext: "woff2",
      extEnum: .woff2,
      bytesCount: 8,
      matches: { bytes, _ in
        return (bytes[0] == 0x77 && bytes[1] == 0x4F && bytes[2] == 0x46 && bytes[3] == 0x32) &&
          ((bytes[4] == 0x00 && bytes[5] == 0x01 && bytes[6] == 0x00 && bytes[7] == 0x00) ||
          (bytes[4] == 0x4F && bytes[5] == 0x54 && bytes[6] == 0x54 && bytes[7] == 0x4F))
      }
    ),
    MimeType(
      mime: "application/octet-stream",
      ext: "eot",
      extEnum: .eot,
      bytesCount: 11,
      matches: { bytes, _ in
        return (bytes[34] == 0x4C && bytes[35] == 0x50) &&
          ((bytes[8] == 0x00 && bytes[9] == 0x00 && bytes[10] == 0x01) ||
          (bytes[8] == 0x01 && bytes[9] == 0x00 && bytes[10] == 0x02) ||
          (bytes[8] == 0x02 && bytes[9] == 0x00 && bytes[10] == 0x02))
      }
    ),
    MimeType(
      mime: "application/font-sfnt",
      ext: "ttf",
      extEnum: .ttf,
      bytesCount: 5,
      matches: { bytes, _ in
        return bytes[0] == 0x00 && bytes[1] == 0x01 && bytes[2] == 0x00 && bytes[3] == 0x00 && bytes[4] == 0x00
      }
    ),
    MimeType(
      mime: "application/font-sfnt",
      ext: "otf",
      extEnum: .otf,
      bytesCount: 5,
      matches: { bytes, _ in
        return bytes[0] == 0x4F && bytes[1] == 0x54 && bytes[2] == 0x54 && bytes[3] == 0x4F && bytes[4] == 0x00
      }
    ),
    MimeType(
      mime: "image/x-icon",
      ext: "ico",
      extEnum: .ico,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x00 && bytes[1] == 0x00 && bytes[2] == 0x01 && bytes[3] == 0x00
      }
    ),
    MimeType(
      mime: "video/x-flv",
      ext: "flv",
      extEnum: .flv,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x46 && bytes[1] == 0x4C && bytes[2] == 0x56 && bytes[3] == 0x01
      }
    ),
    MimeType(
      mime: "application/postscript",
      ext: "ps",
      extEnum: .ps,
      bytesCount: 2,
      matches: { bytes, _ in
        return bytes[0] == 0x25 && bytes[1] == 0x21
      }
    ),
    MimeType(
      mime: "application/x-xz",
      ext: "xz",
      extEnum: .xz,
      bytesCount: 6,
      matches: { bytes, _ in
        return bytes[0] == 0xFD && bytes[1] == 0x37 && bytes[2] == 0x7A && bytes[3] == 0x58 && bytes[4] == 0x5A && bytes[5] == 0x00
      }
    ),
    MimeType(
      mime: "application/x-sqlite3",
      ext: "sqlite",
      extEnum: .sqlite,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x53 && bytes[1] == 0x51 && bytes[2] == 0x4C && bytes[3] == 0x69
      }
    ),
    MimeType(
      mime: "application/x-nintendo-nes-rom",
      ext: "nes",
      extEnum: .nes,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x4E && bytes[1] == 0x45 && bytes[2] == 0x53 && bytes[3] == 0x1A
      }
    ),
    MimeType(
      mime: "application/x-google-chrome-extension",
      ext: "crx",
      extEnum: .crx,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0x43 && bytes[1] == 0x72 && bytes[2] == 0x32 && bytes[3] == 0x34
      }
    ),
    MimeType(
      mime: "application/vnd.ms-cab-compressed",
      ext: "cab",
      extEnum: .cab,
      bytesCount: 4,
      matches: { bytes, _ in
        return (bytes[0] == 0x4D && bytes[1] == 0x53 && bytes[2] == 0x43 && bytes[3] == 0x46) ||
          (bytes[0] == 0x49 && bytes[1] == 0x53 && bytes[2] == 0x63 && bytes[3] == 0x28)
      }
    ),

    // Needs to be before `ar` check
    MimeType(
      mime: "application/x-deb",
      ext: "deb",
      extEnum: .deb,
      bytesCount: 21,
      matches: { bytes, _ in
        return bytes[0] == 0x21 && bytes[1] == 0x3C && bytes[2] == 0x61 && bytes[3] == 0x72 &&
          bytes[4] == 0x63 && bytes[5] == 0x68 && bytes[6] == 0x3E && bytes[7] == 0x0A &&
          bytes[8] == 0x64 && bytes[9] == 0x65 && bytes[10] == 0x62 && bytes[11] == 0x69 &&
          bytes[12] == 0x61 && bytes[13] == 0x6E && bytes[14] == 0x2D && bytes[15] == 0x62 &&
          bytes[16] == 0x69 && bytes[17] == 0x6E && bytes[18] == 0x61 && bytes[19] == 0x72 && bytes[20] == 0x79
      }
    ),
    MimeType(
      mime: "application/x-unix-archive",
      ext: "ar",
      extEnum: .ar,
      bytesCount: 7,
      matches: { bytes, _ in
        return bytes[0] == 0x21 && bytes[1] == 0x3C && bytes[2] == 0x61 && bytes[3] == 0x72 && bytes[4] == 0x63 && bytes[5] == 0x68 && bytes[6] == 0x3E
      }
    ),
    MimeType(
      mime: "application/x-rpm",
      ext: "rpm",
      extEnum: .rpm,
      bytesCount: 4,
      matches: { bytes, _ in
        return bytes[0] == 0xED && bytes[1] == 0xAB && bytes[2] == 0xEE && bytes[3] == 0xDB
      }
    ),
    MimeType(
      mime: "application/x-compress",
      ext: "Z",
      extEnum: .z,
      bytesCount: 2,
      matches: { bytes, _ in
        return (bytes[0] == 0x1F && bytes[1] == 0xA0) || (bytes[0] == 0x1F && bytes[1] == 0x9D)
      }
    ),
    MimeType(
      mime: "application/x-lzip",
      ext: "lz",
      extEnum: .lz,
      bytesCount: 2,
      matches: { bytes, _ in
        return bytes[0] == 0x4C && bytes[1] == 0x5A && bytes[2] == 0x49 && bytes[3] == 0x50
      }
    ),
    MimeType(
      mime: "application/x-msi",
      ext: "msi",
      extEnum: .msi,
      bytesCount: 8,
      matches: { bytes, _ in
        return bytes[0] == 0xD0 && bytes[1] == 0xCF && bytes[2] == 0x11 && bytes[3] == 0xE0 && bytes[4] == 0xA1 && bytes[5] == 0xB1 && bytes[6] == 0x1A && bytes[7] == 0xE1
      }
    ),
    MimeType(
      mime: "application/mxf",
      ext: "mxf",
      extEnum: .mxf,
      bytesCount: 14,
      matches: { bytes, _ in
        return bytes[0] == 0x06 && bytes[1] == 0x0E && bytes[2] == 0x2B && bytes[3] == 0x34 &&
          bytes[4] == 0x02 && bytes[5] == 0x05 && bytes[6] == 0x01 && bytes[7] == 0x01 &&
          bytes[8] == 0x0D && bytes[9] == 0x01 && bytes[10] == 0x02 && bytes[11] == 0x01 && bytes[12] == 0x01 && bytes[13] == 0x02
      }
    )
  ]
}

