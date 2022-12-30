import Foundation

let n = Int(readLine()!)!
var field = [[Int]]()
let dir = [1, 0, -1, 0, 1]
var number = 2

for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    field.append(row)
}

func mapping(_ r: Int, _ c: Int, _ number: Int) {
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
    var queue = Queue<(r: Int, c: Int)>()

    queue.push((r, c))
    while !queue.isEmpty {
        let coord = queue.pop()
        if coord.r < 0 || coord.r >= n || coord.c < 0 || coord.c >= n || field[coord.r][coord.c] != 1 || visited[coord.r][coord.c] { continue }

        visited[coord.r][coord.c] = true
        field[coord.r][coord.c] = number

        for i in 0...3 {
            let nr = coord.r + dir[i]
            let nc = coord.c + dir[i + 1]

            queue.push((nr, nc))
        }
    }
}

func solution(_ n: Int, _ field: [[Int]]) -> Int {
    var answer = 987654321
    
    func bfs(_ num: Int) -> Int {

        var queue = Queue<(r: Int, c: Int)>()
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
        var result = 0

        for i in 0..<n {
            for j in 0..<n {
                if field[i][j] == num {
                    queue.push((i, j))
                    visited[i][j] = true
                }
            }
        }

        while !queue.isEmpty {
            let s = queue.count

            for _ in 0..<s {
                let coord = queue.pop()
                let r = coord.r, c = coord.c

                visited[r][c] = true

                for i in 0...3 {
                    let nr = r + dir[i]
                    let nc = c + dir[i + 1]

                    if 0 <= nr && nr < n && 0 <= nc && nc < n {
                        if field[nr][nc] != 0 && field[nr][nc] != num {
                            return result
                        } else if field[nr][nc] == num || visited[nr][nc] { 
                            continue 
                        }
                        queue.push((nr, nc))
                    }
                }
            }

            result += 1
        }
        
        return -1
    }

    for i in 2..<number {
        let res = bfs(i)
        if res > 0 {
            answer = res < answer ? res : answer
        }
    }

    return answer
}

for i in 0..<n {
    for j in 0..<n {
        if field[i][j] == 1 {
            mapping(i, j, number)
            number += 1
        }
    }
}

print(solution(n, field))

struct Queue<Element> {
    private var inbox: [Element] = []
    private var outbox: [Element] = []
    
    var isEmpty: Bool{
        return inbox.isEmpty && outbox.isEmpty
    }
    
    var count: Int{
        return inbox.count + outbox.count
    }
    
    mutating func push(_ n: Element) {
        inbox.append(n)
    }
    
    mutating func pop() -> Element {
        if outbox.isEmpty {
            outbox = inbox.reversed()
            inbox.removeAll()
        }
        return outbox.removeLast()
    }
}