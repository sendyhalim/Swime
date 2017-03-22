public struct MimeType {
  let ext: String
  let value: String
  let magicNumbers: [UInt8]

  static let specifications: [String: MimeType] = [
    "7z": MimeType(
      ext: "7z",
      value: "application/x-7z-compressed",
      magicNumbers: [0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C]
    )
    /* "amr", */
    /* "ar", */
    /* "avi", */
    /* "bmp", */
    /* "bz2", */
    /* "cab", */
    /* "cr2", */
    /* "crx", */
    /* "deb", */
    /* "dmg", */
    /* "eot", */
    /* "epub", */
    /* "exe", */
    /* "flac", */
    /* "flif", */
    /* "flv", */
    /* "gif", */
    /* "ico", */
    /* "jpg", */
    /* "jxr", */
    /* "m4a", */
    /* "m4v", */
    /* "mid", */
    /* "mkv", */
    /* "mov", */
    /* "mp3", */
    /* "mp4", */
    /* "mpg", */
    /* "msi", */
    /* "mxf", */
    /* "nes", */
    /* "ogg", */
    /* "opus", */
    /* "otf", */
    /* "pdf", */
    /* "png", */
    /* "ps", */
    /* "psd", */
    /* "rar", */
    /* "rpm", */
    /* "rtf", */
    /* "sqlite", */
    /* "swf", */
    /* "tar", */
    /* "tar.Z", */
    /* "tar.gz", */
    /* "tar.lz", */
    /* "tar.xz", */
    /* "ttf", */
    /* "wav", */
    /* "webm", */
    /* "webp", */
    /* "wmv", */
    /* "woff", */
    /* "woff2", */
    /* "xpi", */
    /* "zip" */
  ]
}
