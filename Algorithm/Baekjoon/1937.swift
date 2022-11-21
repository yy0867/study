import Foundation

let n = Int(readLine()!)!
var field = [[Int]]()

for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int(String($0))! }
    field.append(row)
}

func solution(_ n: Int, _ field: [[Int]]) -> Int {
    var record = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    let dir = [-1, 0, 1, 0, -1]

    func dfs(_ r: Int, _ c: Int) -> Int {
        if record[r][c] != 0 {
            return record[r][c]
        }
        record[r][c] = 1

        var maxValue = -1
        for d in 0...3 {
            let nextR = r + dir[d]
            let nextC = c + dir[d + 1]

            if nextR < 0 || nextR >= n || nextC < 0 || nextC >= n { continue }
            if field[nextR][nextC] > field[r][c] {
                let cur = dfs(nextR, nextC)
                maxValue = cur > maxValue ? cur : maxValue
            }
        }

        record[r][c] += maxValue

        return record[r][c]
    }

    var answer = -1

    for r in 0..<n {
        for c in 0..<n {
            let cur = dfs(r, c)
            answer = cur > answer ? cur : answer
        }
    }

    return answer + 1
}

print(solution(n, field))