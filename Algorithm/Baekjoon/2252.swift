import Foundation

func solution(_ n: Int, _ list: [[Int]], _ inDegree: [Int]) -> String {
    var starts = [Int]()
    for (i, deg) in inDegree.enumerated() {
        if i == 0 { continue }
        if deg == 0 { starts.append(i) }
    }

    var orders = [[Int]]()
    var queue = Queue()
    var degree = inDegree

    for start in starts {
        var visited = [Bool](repeating: false, count: n + 1)
        var order = [Int]()
        queue.push(start)

        while !queue.isEmpty {
            let node = queue.pop()
            if visited[node] { continue }
            visited[node] = true
            order.append(node)
            for nextNode in list[node] {
                if !visited[nextNode] {
                    degree[nextNode] -= 1
                    if degree[nextNode] == 0 {
                        queue.push(nextNode)
                    }
                }
            }
        }

        orders.append(order)
    }

    return orders.flatMap { $0 }.map { String($0) }.joined(separator: " ")
}

let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nm[0]
var list = [[Int]](repeating: [], count: n + 1)
var inDegree = [Int](repeating: 0, count: n + 1)
for _ in 0..<nm[1] {
    let ab = readLine()!.split(separator: " ").map { Int(String($0))! }
    let a = ab[0], b = ab[1]
    list[a].append(b)
    inDegree[b] += 1
}

print(solution(n, list, inDegree))

// Queue
struct Queue {
    var queue = [Int]()
    var head = 0
    var isEmpty: Bool { head >= queue.count }

    mutating func push(_ element: Int) {
        queue.append(element)
    }

    mutating func pop() -> Int {
        let v = queue[head]
        head += 1

        if head > 1000 {
            queue.removeFirst(head)
            head = 0
        }

        return v
    }
}