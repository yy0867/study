import Foundation

func solution(_ field: [[Bool]]) -> Int {
    var count = 0
    var counted = [[Bool]](repeating: [Bool](repeating: false, count: field[0].count), count: field.count)
    let dir = [-1, 0, 1, 0, -1]

    func counting(_ r: Int, _ c: Int) {
        if r < 0 || r >= field.count || c < 0 || c >= field[0].count { return }
        if counted[r][c] || !field[r][c] { return }
        counted[r][c] = true

        for i in 0...3 { 
            counting(r + dir[i], c + dir[i + 1])
        }
    }

    for i in 0..<field.count {
        for j in 0..<field[0].count {
            if counted[i][j] || !field[i][j] { continue }
            counting(i, j)
            count += 1
        }
    }

    return count
}

let t = Int(readLine()!)!
var result = [Int]()
for _ in 0..<t {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! } // m n k
    var field = [[Bool]](repeating: [Bool](repeating: false, count: input[0]), count: input[1])

    for _ in 0..<input[2] {
        let coord = readLine()!.split(separator: " ").map { Int(String($0))! }
        field[coord[1]][coord[0]] = true
    }

    result.append(solution(field))
}

for r in result { print(r) }