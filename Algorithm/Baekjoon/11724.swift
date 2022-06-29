import Foundation

func solution(_ n: Int, _ nodes: [[Int]]) -> Int {
    // var queue = Queue()
    var queue = [Int]()
    var isComponent = [Bool](repeating: false, count: n + 1)
    var count = 0

    for i in 1...n where !isComponent[i] {
        count += 1
        // queue.push(i)
        queue.append(i)
        while !queue.isEmpty {
            // let node = queue.pop()
            let node = queue.removeLast()
            isComponent[node] = true
            for j in nodes[node] where !isComponent[j] {
                queue.append(j)
            }
        }
    }

    return count
}

let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
var nodes = [[Int]](repeating: [], count: nm[0] + 1)
for _ in 0..<nm[1] {
    let node = readLine()!.split(separator: " ").map { Int(String($0))! }
    nodes[node[0]].append(node[1])
    nodes[node[1]].append(node[0])
}

if nm[1] == 0 {
    print(nm[0])
} else {
    print(solution(nm[0], nodes))
}

// Queue
struct Queue {
    var queue = [Int]()
    var head = 0
    var isEmpty: Bool { head >= queue.count }

    mutating func push(_ element: Int) { queue.append(element) }
    mutating func pop() -> Int {
        let v = queue[head]
        head += 1

        if head >= 1000 {
            queue.removeFirst(head)
            head = 0
        }

        return v
    }
}