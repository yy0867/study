import Foundation

let n = Int(readLine()!)!
var grid = [[String]]()
var redGreenGrid = [[String]]()

for _ in 0..<n {
    let row = readLine()!.map { String($0) }
    grid.append(row)
    redGreenGrid.append(row.map { 
        if $0 == "R" { return "G"} 
        else { return $0 }
    })
}

func solution(_ grid: [[String]]) -> Int {
    var answer = 0
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
    let dir = [1, 0, -1, 0, 1]

    func dfs(_ r: Int, _ c: Int) {
        if visited[r][c] { return }
        visited[r][c] = true

        for d in 0...3 {
            let nextR = r + dir[d]
            let nextC = c + dir[d + 1]

            if nextR >= 0 && nextR < n && nextC >= 0 && nextC < n && grid[r][c] == grid[nextR][nextC] {
                dfs(nextR, nextC)
            }
        }
    }

    for i in 0..<n {
        for j in 0..<n {
            if !visited[i][j] {
                dfs(i, j)
                answer += 1
            }
        }
    }

    return answer
}

print("\(solution(grid)) \(solution(redGreenGrid))")