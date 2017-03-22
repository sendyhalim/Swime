import Foundation

public struct Swime {
  let data: Data

  public func mimeType() -> MimeType? {
    let bytes = readBytes(count: 262)

    if bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF {
      return MimeType(
        ext: "jpg",
        mime: "image/jpeg"
      )
    }

    if bytes[0] == 0x89 && bytes[1] == 0x50 && bytes[2] == 0x4E && bytes[3] == 0x47 {
      return MimeType(
        ext: "png",
        mime: "image/png"
      )
    }

    if bytes[0] == 0x47 && bytes[1] == 0x49 && bytes[2] == 0x46 {
      return MimeType(
        ext: "gif",
        mime: "image/gif"
      )
    }

    if bytes[8] == 0x57 && bytes[9] == 0x45 && bytes[10] == 0x42 && bytes[11] == 0x50 {
      return MimeType(
        ext: "webp",
        mime: "image/webp"
      )
    }

    if bytes[0] == 0x46 && bytes[1] == 0x4C && bytes[2] == 0x49 && bytes[3] == 0x46 {
      return MimeType(
        ext: "flif",
        mime: "image/flif"
      )
    }

    // Needs to be before `tif` check
    if ((bytes[0] == 0x49 && bytes[1] == 0x49 && bytes[2] == 0x2A && bytes[3] == 0x0) ||
        (bytes[0] == 0x4D && bytes[1] == 0x4D && bytes[2] == 0x0 && bytes[3] == 0x2A)) &&
       bytes[8] == 0x43 && bytes[9] == 0x52 {
      return MimeType(
        ext: "cr2",
        mime: "image/x-canon-cr2"
      )
    }

    if (bytes[0] == 0x49 && bytes[1] == 0x49 && bytes[2] == 0x2A && bytes[3] == 0x0) || (bytes[0] == 0x4D && bytes[1] == 0x4D && bytes[2] == 0x0 && bytes[3] == 0x2A) {
      return MimeType(
        ext: "tif",
        mime: "image/tiff"
      )
    }

    if bytes[0] == 0x42 && bytes[1] == 0x4D {
      return MimeType(
        ext: "bmp",
        mime: "image/bmp"
      )
    }

    if bytes[0] == 0x49 && bytes[1] == 0x49 && bytes[2] == 0xBC {
      return MimeType(
        ext: "jxr",
        mime: "image/vnd.ms-photo"
      )
    }

    if bytes[0] == 0x38 && bytes[1] == 0x42 && bytes[2] == 0x50 && bytes[3] == 0x53 {
      return MimeType(
        ext: "psd",
        mime: "image/vnd.adobe.photoshop"
      )
    }

    // Needs to be before `zip` check
    if bytes[0] == 0x50 && bytes[1] == 0x4B && bytes[2] == 0x3 && bytes[3] == 0x4 && bytes[30] == 0x6D && bytes[31] == 0x69 && bytes[32] == 0x6D && bytes[33] == 0x65 && bytes[34] == 0x74 && bytes[35] == 0x79 && bytes[36] == 0x70 && bytes[37] == 0x65 && bytes[38] == 0x61 && bytes[39] == 0x70 && bytes[40] == 0x70 && bytes[41] == 0x6C && bytes[42] == 0x69 && bytes[43] == 0x63 && bytes[44] == 0x61 && bytes[45] == 0x74 && bytes[46] == 0x69 && bytes[47] == 0x6F && bytes[48] == 0x6E && bytes[49] == 0x2F && bytes[50] == 0x65 && bytes[51] == 0x70 && bytes[52] == 0x75 && bytes[53] == 0x62 && bytes[54] == 0x2B && bytes[55] == 0x7A && bytes[56] == 0x69 && bytes[57] == 0x70 {
      return MimeType(
        ext: "epub",
        mime: "application/epub+zip"
      )
    }

    // Needs to be before `zip` check
    // assumes signed .xpi from addons.mozilla.org
    if bytes[0] == 0x50 && bytes[1] == 0x4B && bytes[2] == 0x3 && bytes[3] == 0x4 && bytes[30] == 0x4D && bytes[31] == 0x45 && bytes[32] == 0x54 && bytes[33] == 0x41 && bytes[34] == 0x2D && bytes[35] == 0x49 && bytes[36] == 0x4E && bytes[37] == 0x46 && bytes[38] == 0x2F && bytes[39] == 0x6D && bytes[40] == 0x6F && bytes[41] == 0x7A && bytes[42] == 0x69 && bytes[43] == 0x6C && bytes[44] == 0x6C && bytes[45] == 0x61 && bytes[46] == 0x2E && bytes[47] == 0x72 && bytes[48] == 0x73 && bytes[49] == 0x61 {
      return MimeType(
        ext: "xpi",
        mime: "application/x-xpinstall"
      )
    }

    if bytes[0] == 0x50 && bytes[1] == 0x4B && (bytes[2] == 0x3 || bytes[2] == 0x5 || bytes[2] == 0x7) && (bytes[3] == 0x4 || bytes[3] == 0x6 || bytes[3] == 0x8) {
      return MimeType(
        ext: "zip",
        mime: "application/zip"
      )
    }

    if bytes[257] == 0x75 && bytes[258] == 0x73 && bytes[259] == 0x74 && bytes[260] == 0x61 && bytes[261] == 0x72 {
      return MimeType(
        ext: "tar",
        mime: "application/x-tar"
      )
    }

    if bytes[0] == 0x52 && bytes[1] == 0x61 && bytes[2] == 0x72 && bytes[3] == 0x21 && bytes[4] == 0x1A && bytes[5] == 0x7 && (bytes[6] == 0x0 || bytes[6] == 0x1) {
      return MimeType(
        ext: "rar",
        mime: "application/x-rar-compressed"
      )
    }

    if bytes[0] == 0x1F && bytes[1] == 0x8B && bytes[2] == 0x8 {
      return MimeType(
        ext: "gz",
        mime: "application/gzip"
      )
    }

    if bytes[0] == 0x42 && bytes[1] == 0x5A && bytes[2] == 0x68 {
      return MimeType(
        ext: "bz2",
        mime: "application/x-bzip2"
      )
    }

    if bytes[0] == 0x37 && bytes[1] == 0x7A && bytes[2] == 0xBC && bytes[3] == 0xAF && bytes[4] == 0x27 && bytes[5] == 0x1C {
      return MimeType(
        ext: "7z",
        mime: "application/x-7z-compressed"
      )
    }

    if bytes[0] == 0x78 && bytes[1] == 0x01 {
      return MimeType(
        ext: "dmg",
        mime: "application/x-apple-diskimage"
      )
    }

    if (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && (bytes[3] == 0x18 || bytes[3] == 0x20) && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70) ||
       (bytes[0] == 0x33 && bytes[1] == 0x67 && bytes[2] == 0x70 && bytes[3] == 0x35) ||
       (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x1C && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x6D && bytes[9] == 0x70 && bytes[10] == 0x34 && bytes[11] == 0x32 && bytes[16] == 0x6D && bytes[17] == 0x70 && bytes[18] == 0x34 && bytes[19] == 0x31 && bytes[20] == 0x6D && bytes[21] == 0x70 && bytes[22] == 0x34 && bytes[23] == 0x32 && bytes[24] == 0x69 && bytes[25] == 0x73 && bytes[26] == 0x6F && bytes[27] == 0x6D) ||
       (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x1C && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x69 && bytes[9] == 0x73 && bytes[10] == 0x6F && bytes[11] == 0x6D) ||
       (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x1c && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x6D && bytes[9] == 0x70 && bytes[10] == 0x34 && bytes[11] == 0x32 && bytes[12] == 0x0 && bytes[13] == 0x0 && bytes[14] == 0x0 && bytes[15] == 0x0) {
      return MimeType(
        ext: "mp4",
        mime: "video/mp4"
      )
    }

    if (bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x1C && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x4D && bytes[9] == 0x34 && bytes[10] == 0x56) {
      return MimeType(
        ext: "m4v",
        mime: "video/x-m4v"
      )
    }

    if bytes[0] == 0x4D && bytes[1] == 0x54 && bytes[2] == 0x68 && bytes[3] == 0x64 {
      return MimeType(
        ext: "mid",
        mime: "audio/midi"
      )
    }

    // https://github.com/threatstack/libmagic/blob/master/magic/Magdir/matroska
    if bytes[0] == 0x1A && bytes[1] == 0x45 && bytes[2] == 0xDF && bytes[3] == 0xA3 {
      let _bytes = Array(readBytes(count: 4100)[4 ..< 4100])
      var idPos = -1

      for i in 0 ..< (_bytes.count - 1) {
        if _bytes[i] == 0x42 && _bytes[i + 1] == 0x82 {
          idPos = i
          break;
        }
      }

      if idPos > -1 {
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

        if findDocType("matroska") {
          return MimeType(
            ext: "mkv",
            mime: "video/x-matroska"
          )
        }

        if findDocType("webm") {
          return MimeType(
            ext: "webm",
            mime: "video/webm"
          )
        }
      }
    }

    if bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x0 && bytes[3] == 0x14 && bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 {
      return MimeType(
        ext: "mov",
        mime: "video/quicktime"
      )
    }

    if bytes[0] == 0x52 && bytes[1] == 0x49 && bytes[2] == 0x46 && bytes[3] == 0x46 && bytes[8] == 0x41 && bytes[9] == 0x56 && bytes[10] == 0x49 {
      return MimeType(
        ext: "avi",
        mime: "video/x-msvideo"
      )
    }

    if bytes[0] == 0x30 && bytes[1] == 0x26 && bytes[2] == 0xB2 && bytes[3] == 0x75 && bytes[4] == 0x8E && bytes[5] == 0x66 && bytes[6] == 0xCF && bytes[7] == 0x11 && bytes[8] == 0xA6 && bytes[9] == 0xD9 {
      return MimeType(
        ext: "wmv",
        mime: "video/x-ms-wmv"
      )
    }

    if bytes[0] == 0x0 && bytes[1] == 0x0 && bytes[2] == 0x1 && String(format: "%2X", bytes[3]) == "b" {
      return MimeType(
        ext: "mpg",
        mime: "video/mpeg"
      )
    }

    if (bytes[0] == 0x49 && bytes[1] == 0x44 && bytes[2] == 0x33) || (bytes[0] == 0xFF && bytes[1] == 0xfb) {
      return MimeType(
        ext: "mp3",
        mime: "audio/mpeg"
      )
    }

    if (bytes[4] == 0x66 && bytes[5] == 0x74 && bytes[6] == 0x79 && bytes[7] == 0x70 && bytes[8] == 0x4D && bytes[9] == 0x34 && bytes[10] == 0x41) || (bytes[0] == 0x4D && bytes[1] == 0x34 && bytes[2] == 0x41 && bytes[3] == 0x20) {
      return MimeType(
        ext: "m4a",
        mime: "audio/m4a"
      )
    }

    // Needs to be before `ogg` check
    if bytes[28] == 0x4F && bytes[29] == 0x70 && bytes[30] == 0x75 && bytes[31] == 0x73 && bytes[32] == 0x48 && bytes[33] == 0x65 && bytes[34] == 0x61 && bytes[35] == 0x64 {
      return MimeType(
        ext: "opus",
        mime: "audio/opus"
      )
    }

    if bytes[0] == 0x4F && bytes[1] == 0x67 && bytes[2] == 0x67 && bytes[3] == 0x53 {
      return MimeType(
        ext: "ogg",
        mime: "audio/ogg"
      )
    }

    if bytes[0] == 0x66 && bytes[1] == 0x4C && bytes[2] == 0x61 && bytes[3] == 0x43 {
      return MimeType(
        ext: "flac",
        mime: "audio/x-flac"
      )
    }

    if bytes[0] == 0x52 && bytes[1] == 0x49 && bytes[2] == 0x46 && bytes[3] == 0x46 && bytes[8] == 0x57 && bytes[9] == 0x41 && bytes[10] == 0x56 && bytes[11] == 0x45 {
      return MimeType(
        ext: "wav",
        mime: "audio/x-wav"
      )
    }

    if bytes[0] == 0x23 && bytes[1] == 0x21 && bytes[2] == 0x41 && bytes[3] == 0x4D && bytes[4] == 0x52 && bytes[5] == 0x0A {
      return MimeType(
        ext: "amr",
        mime: "audio/amr"
      )
    }

    if bytes[0] == 0x25 && bytes[1] == 0x50 && bytes[2] == 0x44 && bytes[3] == 0x46 {
      return MimeType(
        ext: "pdf",
        mime: "application/pdf"
      )
    }

    if bytes[0] == 0x4D && bytes[1] == 0x5A {
      return MimeType(
        ext: "exe",
        mime: "application/x-msdownload"
      )
    }

    if (bytes[0] == 0x43 || bytes[0] == 0x46) && bytes[1] == 0x57 && bytes[2] == 0x53 {
      return MimeType(
        ext: "swf",
        mime: "application/x-shockwave-flash"
      )
    }

    if bytes[0] == 0x7B && bytes[1] == 0x5C && bytes[2] == 0x72 && bytes[3] == 0x74 && bytes[4] == 0x66 {
      return MimeType(
        ext: "rtf",
        mime: "application/rtf"
      )
    }

    if (bytes[0] == 0x77 && bytes[1] == 0x4F && bytes[2] == 0x46 && bytes[3] == 0x46) &&
         ((bytes[4] == 0x00 && bytes[5] == 0x01 && bytes[6] == 0x00 && bytes[7] == 0x00) ||
          (bytes[4] == 0x4F && bytes[5] == 0x54 && bytes[6] == 0x54 && bytes[7] == 0x4F)) {
      return MimeType(
        ext: "woff",
        mime: "application/font-woff"
      )
    }

    if (bytes[0] == 0x77 && bytes[1] == 0x4F && bytes[2] == 0x46 && bytes[3] == 0x32) &&
        ((bytes[4] == 0x00 && bytes[5] == 0x01 && bytes[6] == 0x00 && bytes[7] == 0x00) ||
         (bytes[4] == 0x4F && bytes[5] == 0x54 && bytes[6] == 0x54 && bytes[7] == 0x4F)) {
      return MimeType(
        ext: "woff2",
        mime: "application/font-woff"
      )
    }

    if (bytes[34] == 0x4C && bytes[35] == 0x50) &&
        ((bytes[8] == 0x00 && bytes[9] == 0x00 && bytes[10] == 0x01) ||
         (bytes[8] == 0x01 && bytes[9] == 0x00 && bytes[10] == 0x02) ||
         (bytes[8] == 0x02 && bytes[9] == 0x00 && bytes[10] == 0x02)) {
      return MimeType(
        ext: "eot",
        mime: "application/octet-stream"
      )
    }

    if bytes[0] == 0x00 && bytes[1] == 0x01 && bytes[2] == 0x00 && bytes[3] == 0x00 && bytes[4] == 0x00 {
      return MimeType(
        ext: "ttf",
        mime: "application/font-sfnt"
      )
    }

    if bytes[0] == 0x4F && bytes[1] == 0x54 && bytes[2] == 0x54 && bytes[3] == 0x4F && bytes[4] == 0x00 {
      return MimeType(
        ext: "otf",
        mime: "application/font-sfnt"
      )
    }

    if bytes[0] == 0x00 && bytes[1] == 0x00 && bytes[2] == 0x01 && bytes[3] == 0x00 {
      return MimeType(
        ext: "ico",
        mime: "image/x-icon"
      )
    }

    if bytes[0] == 0x46 && bytes[1] == 0x4C && bytes[2] == 0x56 && bytes[3] == 0x01 {
      return MimeType(
        ext: "flv",
        mime: "video/x-flv"
      )
    }

    if bytes[0] == 0x25 && bytes[1] == 0x21 {
      return MimeType(
        ext: "ps",
        mime: "application/postscript"
      )
    }

    if bytes[0] == 0xFD && bytes[1] == 0x37 && bytes[2] == 0x7A && bytes[3] == 0x58 && bytes[4] == 0x5A && bytes[5] == 0x00 {
      return MimeType(
        ext: "xz",
        mime: "application/x-xz"
      )
    }

    if bytes[0] == 0x53 && bytes[1] == 0x51 && bytes[2] == 0x4C && bytes[3] == 0x69 {
      return MimeType(
        ext: "sqlite",
        mime: "application/x-sqlite3"
      )
    }

    if bytes[0] == 0x4E && bytes[1] == 0x45 && bytes[2] == 0x53 && bytes[3] == 0x1A {
      return MimeType(
        ext: "nes",
        mime: "application/x-nintendo-nes-rom"
      )
    }

    if bytes[0] == 0x43 && bytes[1] == 0x72 && bytes[2] == 0x32 && bytes[3] == 0x34 {
      return MimeType(
        ext: "crx",
        mime: "application/x-google-chrome-extension"
      )
    }

    if (bytes[0] == 0x4D && bytes[1] == 0x53 && bytes[2] == 0x43 && bytes[3] == 0x46) ||
        (bytes[0] == 0x49 && bytes[1] == 0x53 && bytes[2] == 0x63 && bytes[3] == 0x28) {
      return MimeType(
        ext: "cab",
        mime: "application/vnd.ms-cab-compressed"
      )
    }

    // Needs to be before `ar` check
    if bytes[0] == 0x21 && bytes[1] == 0x3C && bytes[2] == 0x61 && bytes[3] == 0x72 && bytes[4] == 0x63 && bytes[5] == 0x68 && bytes[6] == 0x3E && bytes[7] == 0x0A && bytes[8] == 0x64 && bytes[9] == 0x65 && bytes[10] == 0x62 && bytes[11] == 0x69 && bytes[12] == 0x61 && bytes[13] == 0x6E && bytes[14] == 0x2D && bytes[15] == 0x62 && bytes[16] == 0x69 && bytes[17] == 0x6E && bytes[18] == 0x61 && bytes[19] == 0x72 && bytes[20] == 0x79 {
      return MimeType(
        ext: "deb",
        mime: "application/x-deb"
      )
    }

    if bytes[0] == 0x21 && bytes[1] == 0x3C && bytes[2] == 0x61 && bytes[3] == 0x72 && bytes[4] == 0x63 && bytes[5] == 0x68 && bytes[6] == 0x3E {
      return MimeType(
        ext: "ar",
        mime: "application/x-unix-archive"
      )
    }

    if bytes[0] == 0xED && bytes[1] == 0xAB && bytes[2] == 0xEE && bytes[3] == 0xDB {
      return MimeType(
        ext: "rpm",
        mime: "application/x-rpm"
      )
    }

    if (bytes[0] == 0x1F && bytes[1] == 0xA0) || (bytes[0] == 0x1F && bytes[1] == 0x9D) {
      return MimeType(
        ext: "Z",
        mime: "application/x-compress"
      )
    }

    if bytes[0] == 0x4C && bytes[1] == 0x5A && bytes[2] == 0x49 && bytes[3] == 0x50 {
      return MimeType(
        ext: "lz",
        mime: "application/x-lzip"
      )
    }

    if bytes[0] == 0xD0 && bytes[1] == 0xCF && bytes[2] == 0x11 && bytes[3] == 0xE0 && bytes[4] == 0xA1 && bytes[5] == 0xB1 && bytes[6] == 0x1A && bytes[7] == 0xE1 {
      return MimeType(
        ext: "msi",
        mime: "application/x-msi"
      )
    }

    if bytes[0] == 0x06 && bytes[1] == 0x0E && bytes[2] == 0x2B && bytes[3] == 0x34 && bytes[4] == 0x02 && bytes[5] == 0x05 && bytes[6] == 0x01 && bytes[7] == 0x01 && bytes[8] == 0x0D && bytes[9] == 0x01 && bytes[10] == 0x02 && bytes[11] == 0x01 && bytes[12] == 0x01 && bytes[13] == 0x02 {
      return MimeType(
        ext: "mxf",
        mime: "application/mxf"
      )
    }

    return nil
  }

  public func readBytes(count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)

    data.copyBytes(to: &bytes, count: count)

    return bytes
  }
}

