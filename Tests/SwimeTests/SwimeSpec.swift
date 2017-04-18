import Foundation
import Nimble
import Quick
@testable import Swime

class SwimeSpec: QuickSpec {
  override func spec() {
    describe(".readBytes()") {
      context("when we want to read 4 bytes of string data") {
        let str = "hello"
        let data = str.data(using: .utf8)!
        let swime = Swime(data: data)
        let bytes = swime.readBytes(count: 4)

        it("should return 4 bytes") {
          expect(bytes.count) == 4
        }

        it("should return correct bytes") {
          let endIndex = str.index(str.startIndex, offsetBy: 4)
          let substr = str.substring(to: endIndex)
          let expectation = [UInt8](substr.utf8)

          expect(bytes) == expectation
        }
      }
    }

    describe(".mimeType()") {
      let extensions = [
        "7z",
        "amr",
        "ar",
        "avi",
        "bmp",
        "bz2",
        "cab",
        "cr2",
        "crx",
        "deb",
        "dmg",
        "eot",
        "epub",
        "exe",
        "flac",
        "flif",
        "flv",
        "gif",
        "ico",
        "jpg",
        "jxr",
        "m4a",
        "m4v",
        "mid",
        "mkv",
        "mov",
        "mp3",
        "mp4",
        "mpg",
        "msi",
        "mxf",
        "nes",
        "ogg",
        "opus",
        "otf",
        "pdf",
        "png",
        "ps",
        "psd",
        "rar",
        "rpm",
        "rtf",
        "sqlite",
        "swf",
        "tar",
        "tar.Z",
        "tar.gz",
        "tar.lz",
        "tar.xz",
        "ttf",
        "wav",
        "webm",
        "webp",
        "wmv",
        "woff",
        "woff2",
        "xpi",
        "zip"
      ]

      let mimeTypeByExtension = [
        "tar.Z": "application/x-compress",
        "tar.gz": "application/gzip",
        "tar.lz": "application/x-lzip",
        "tar.xz": "application/x-xz"
      ]

      for ext in extensions {
        context("when extension is \(ext)") {
          it("shoud guess the correct mime type") {
            let data = loadFileData(path: "/Tests/SwimeTests/fixtures/fixture.\(ext)")
            let swime = Swime(data: data)

            if let mimeType = mimeTypeByExtension[ext] {
              expect(swime.mimeType()?.mime) == mimeType
            } else {
              expect(swime.mimeType()?.ext) == ext
            }
          }
        }
      }
    }

    describe(".init(bytes:") {
      context("when given jpeg bytes") {
        it("should return image/jpeg mime type") {
          let bytes: [UInt8] = [255, 216, 255]
          let swime = Swime(bytes: bytes)

          expect(swime.mimeType()?.mime) == "image/jpeg"
        }
      }

      context("when given 7z bytes") {
        it("should return application/x-7z-compressed") {
          let bytes: [UInt8] = [55, 122, 188, 175, 39, 28]
          let swime = Swime(bytes: bytes)

          expect(swime.mimeType()?.mime) == "application/x-7z-compressed"
        }
      }
    }

    describe(".type") {
      context("when file type is image/jpeg") {
        it("should return true") {
          let data: Data = loadFileData(path: "/Tests/SwimeTests/fixtures/fixture.jpg")
          let mimeType = Swime.mimeType(data: data)

          expect(mimeType?.type) == .jpg
        }
      }

      context("when file type is application/pdf") {
        it("should return true") {
          let data: Data = loadFileData(path: "/Tests/SwimeTests/fixtures/fixture.pdf")
          let mimeType = Swime.mimeType(data: data)

          expect(mimeType?.type) == .pdf
        }
      }

      context("when file type is not image/jpeg") {
        it("should return true") {
          let data: Data = loadFileData(path: "/Tests/SwimeTests/fixtures/fixture.png")
          let mimeType = Swime.mimeType(data: data)

          expect(mimeType?.type) != .jpg
        }
      }
    }
  }
}
