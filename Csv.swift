//
//  CSV
//  Modified by Mark Price on 08/14/15
//

import Foundation

public class CSV {
    public var headers: [NSString] = []
    public var rows: [Dictionary<NSString, NSString>] = []
    public var columns = Dictionary<NSString, [NSString]>()
    var delimiter = CharacterSet(charactersIn: ",")
    
    public init(content: NSString?, delimiter: CharacterSet, encoding: UInt) throws{
        if let csvStringToParse = content{
            self.delimiter = delimiter

            let newline = NSCharacterSet.newlines
            var lines: [NSString] = []
            csvStringToParse.trimmingCharacters(in: newline).enumerateLines { line, stop in lines.append(line as NSString) }

            self.headers = self.parseHeaders(fromLines: lines)
            self.rows = self.parseRows(fromLines: lines)
            self.columns = self.parseColumns(fromLines: lines)
        }
    }
    
    public convenience init(contentsOfURL url: String) throws {
        let comma = CharacterSet(charactersIn: ",")
        let csvString: String?
        do {
            csvString = try String(contentsOfFile: url, encoding: String.Encoding.utf8)
        } catch _ {
            csvString = nil
        };
        try self.init(content: csvString as NSString?,delimiter:comma, encoding:String.Encoding.utf8.rawValue)
    }
    
    
    func parseHeaders(fromLines lines: [NSString]) -> [NSString] {
        return lines[0].components(separatedBy: self.delimiter) as [NSString]
    }
    
    func parseRows(fromLines lines: [NSString]) -> [Dictionary<NSString, NSString>] {
        var rows: [Dictionary<NSString, NSString>] = []
        
        for (lineNumber, line) in lines.enumerated() {
            if lineNumber == 0 {
                continue
            }
            
            var row = Dictionary<NSString, NSString>()
            let values = line.components(separatedBy: self.delimiter) as [NSString]
            for (index, header) in self.headers.enumerated() {
                if index < values.count {
                    row[header] = values[index]
                } else {
                    row[header] = ""
                }
            }
            rows.append(row)
        }
        
        return rows
    }
    
    func parseColumns(fromLines lines: [NSString]) -> Dictionary<NSString, [NSString]> {
        var columns = Dictionary<NSString, [NSString]>()
        
        for header in self.headers {
            let column = self.rows.map { row in row[header] != nil ? row[header]! : "" }
            columns[header] = column
        }
        
        return columns
    }
}
