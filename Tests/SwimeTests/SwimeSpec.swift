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
      for (ext, mimeType) in MimeType.specifications {
        context("when extension is \(ext)") {
          let projectDir = FileManager.default.currentDirectoryPath
          let path = "\(projectDir)/Tests/SwimeTests/fixtures/fixture.\(ext)"
          let url = URL(fileURLWithPath: path, isDirectory: false)
          let data = try! Data(contentsOf: url)

          it("shoud guess the correct mime type") {
            let swime = Swime(data: data)
            expect(swime.mimeType()?.value) == Optional.some(mimeType.value)
          }
        }
      }
    }
  }
}

