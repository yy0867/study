import Foundation

let nm = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var field = [[Int]]()

for _ in 0..<n {
    let row = readLine()!.components(separatedBy: " ").map { Int($0)! }
    field.append(row)
}

func solution(_ field: [[Int]]) -> Int {
    var max = -1
    // var visited = [[Bool]]()
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)
    let dir = [1, 0, -1, 0, 1]

    func tetromino(_ r: Int, _ c: Int, _ count: Int, _ sum: Int) {
        if count == 4 {
            max = sum > max ? sum : max
            return 
        }

        for d in 0...3 {
            let nextR = r + dir[d]
            let nextC = c + dir[d + 1]

            if nextR < 0 || nextR >= n || nextC < 0 || nextC >= m || visited[nextR][nextC] { continue }

            visited[nextR][nextC] = true
            tetromino(nextR, nextC, count + 1, sum + field[nextR][nextC])
            visited[nextR][nextC] = false
        }
    }

    func tetrominoMid(_ r: Int, _ c: Int) {
        // ㅗ
        if r - 1 >= 0 && c - 1 >= 0 && c + 1 < m {
            let sum = field[r][c] + field[r - 1][c] + field[r][c - 1] + field[r][c + 1]
            max = sum > max ? sum : max
        }

        // ㅜ
        if r + 1 < n && c - 1 >= 0 && c + 1 < m {
            let sum = field[r][c] + field[r + 1][c] + field[r][c - 1] + field[r][c + 1]
            max = sum > max ? sum : max
        }

        // ㅓ
        if r - 1 >= 0 && r + 1 < n && c - 1 >= 0 {
            let sum = field[r][c] + field[r - 1][c] + field[r + 1][c] + field[r][c - 1]
            max = sum > max ? sum : max
        }

        // ㅏ
        if r - 1 >= 0 && r + 1 < n && c + 1 < m {
            let sum = field[r][c] + field[r - 1][c] + field[r + 1][c] + field[r][c + 1]
            max = sum > max ? sum : max
        }
    }

    for i in 0..<n {
        for j in 0..<m {
            visited[i][j] = true
            tetromino(i, j, 1, field[i][j])
            tetrominoMid(i, j)
            visited[i][j] = false
        }
    }

    return max
}

print(solution(field))