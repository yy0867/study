import Foundation

let nmh = readLine()!.split(separator: " ").map { Int($0)! }
let n = nmh[0], m = nmh[1], h = nmh[2]
var horizontal = [[Int]]()
var ladder = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: h + 1)

for _ in 0..<m {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let r = input[0], c = input[1]

    ladder[r][c] = true
}

func solution() -> Int {
    func dfs(_ ladders: Int, _ curCount: Int) {
        if ladders == curCount {
            if isAllMatch() {
                print(ladders)
                exit(0)
            }
            return
        }

        for j in 1..<n {
            var i = 0
            while i < h {
                i += 1
                if ladder[i][j] || ladder[i][j - 1] || ladder[i][j + 1] { continue }

                ladder[i][j] = true
                dfs(ladders, curCount + 1)
                ladder[i][j] = false

                while i < h && !ladder[i][j - 1] && !ladder[i][j + 1] { i += 1 }
            }
        }
    }

    for i in 0...3 {
        dfs(i, 0)
    }

    return -1
}

func isAllMatch() -> Bool {
    for c in 1...n {
        var cur = c
        for r in 1...h {
            if ladder[r][cur] {
                cur += 1
            } else if ladder[r][cur - 1] {
                cur -= 1
            }
        }
        if cur != c {
            return false
        }
    }

    return true
}

print(solution())