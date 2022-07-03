import Foundation

func solution(_ l: Int, _ knight: (Int, Int, Int), _ dest: (Int, Int)) -> Int {
    if knight.0 == dest.0 && knight.1 == dest.1 { return 0 }
    let dir = [-2, -1, 2, 1, 2, -1, -2, 1, -2]

    var visited = [[Bool]](repeating: [Bool](repeating: false, count: l), count: l)
    var queue = Queue()
    queue.push(knight)

    while !queue.isEmpty {
        let node = queue.pop()

        if visited[node.0][node.1] { continue }
        visited[node.0][node.1] = true

        if node.0 == dest.0 && node.1 == dest.1 { return node.2 }
        for i in 0..<8 {
            let nextR = node.0 + dir[i]
            let nextC = node.1 + dir[i + 1]
            if nextR < 0 || nextR >= l || nextC < 0 || nextC >= l || visited[nextR][nextC] { continue }
            queue.push((nextR, nextC, node.2 + 1))
        }
    }

    return 0
}

let t = Int(readLine()!)!
var answer = [Int]()
for _ in 0..<t {
    let l = Int(readLine()!)!
    let knight = readLine()!.split(separator: " ").map { Int(String($0))! }
    let dest = readLine()!.split(separator: " ").map { Int(String($0))! }
    answer.append(solution(l, (knight[0], knight[1], 0), (dest[0], dest[1])))
}
for ans in answer {
    print(ans)
}

// Queue
struct Queue {
    var queue = [(Int, Int, Int)]()
    var head = 0
    var isEmpty: Bool { head >= queue.count }

    mutating func push(_ element: (Int, Int, Int)) {
        queue.append(element)
    }

    mutating func pop() -> (Int, Int, Int) {
        let v = queue[head]
        head += 1

        if head > 100 {
            queue.removeFirst(head)
            head = 0
        }

        return v
    }
}