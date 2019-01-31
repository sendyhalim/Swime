import Foundation

func loadFileData(path: String) -> Data {
  let projectDir = FileManager.default.currentDirectoryPath
  print(projectDir)
  let absolutePath = "\(projectDir)\(path)"
  let url = URL(fileURLWithPath: absolutePath, isDirectory: false)
  return try! Data(contentsOf: url)
}

