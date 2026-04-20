import Foundation

struct Chapter {
    let title: String
    let content: [String: String]
    
    static func chapters(fromTextFileNamed fileName: String) -> [Chapter] {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "txt"),
              let fileContent = try? String(contentsOfFile: filePath) else { return [] }
        
        var chapters = [Chapter]()
        let chapterBlocks = fileContent.components(separatedBy: "/\n\n")
        
        for chapterBlock in chapterBlocks where !chapterBlock.isEmpty {
            let lines = chapterBlock.components(separatedBy: "\n").filter { !$0.isEmpty }
            if let titleLine = lines.first {
                let title = titleLine.trimmingCharacters(in: .whitespacesAndNewlines)
                var content = [String: String]()
                
                for line in lines.dropFirst(2) {
                    let parts = line.components(separatedBy: " - ")
                    if parts.count == 2 {
                        content[parts[0]] = parts[1]
                    }
                }
                
                chapters.append(Chapter(title: title, content: content))
            }
        }
        
        return chapters
    }
}
