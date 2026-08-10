// Print 10 rows of Pascal's triangle, each row zipped from the previous one shifted both ways.
// Run: swift pascal.swift

let rows = 10

var row = [1]
for _ in 0..<rows {
    print(row.map(String.init).joined(separator: " "))
    row = zip([0] + row, row + [0]).map { $0 + $1 }
}
