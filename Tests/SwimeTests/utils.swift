import Foundation

func loadFileData(path: String) -> Data {
  let url = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent(path)
  return try! Data(contentsOf: url)
}
