import Foundation

func solution(_ n: Int, _ x: Int, _ graph: [[Int]], _ revGraph: [[Int]]) -> Int {
    let INF = Int(Int32.max)

    func dijkstra(start: Int, graph: [[Int]]) -> [Int] {
        var distance = [Int](repeating: INF, count: n)
        var pq = PriorityQueue()

        distance[start] = 0
        pq.push(start)

        while let curNode = pq.pop() {
            for dest in 0..<n {
                if graph[curNode][dest] == INF || graph[curNode][dest] == 0 { continue }

                let currentViaDest = distance[curNode] + graph[curNode][dest]
                if currentViaDest < distance[dest] {
                    distance[dest] = currentViaDest
                    pq.push(dest)
                }
            }
        }

        return distance
    }

    let toDest = dijkstra(start: x, graph: graph)
    let toHome = dijkstra(start: x, graph: revGraph)

    var costs = [Int](repeating: 0, count: n)

    for i in 0..<n {
        costs[i] = toDest[i] + toHome[i]
    }

    return costs.max()!
}

let nmx = readLine()!.split(separator: " ").map { Int($0)! }
let n = nmx[0], m = nmx[1], x = nmx[2] - 1
var graph = [[Int]](repeating: [Int](repeating: Int(Int32.max), count: n), count: n)
var revGraph = [[Int]](repeating: [Int](repeating: Int(Int32.max), count: n), count: n)

for _ in 0..<m {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    graph[row[0] - 1][row[1] - 1] = row[2]
    revGraph[row[1] - 1][row[0] - 1] = row[2]
}

for i in 0..<n { graph[i][i] = 0 }

print(solution(n, x, graph, revGraph))

// PQ
struct PriorityQueue {

    var heap = Heap()
    var isEmpty: Bool { heap.isEmpty }

    mutating func push(_ value: Int) {
        heap.insert(value)
    }

    mutating func pop() -> Int? {
        return heap.remove()
    }
}

// Heap
struct Heap {

    var heap = [Int]()
    var isEmpty: Bool { heap.isEmpty }

    mutating func insert(_ value: Int) {
        heap.append(value)

        var curIndex = heap.count - 1
        while curIndex > 0 {
            let superIndex = superIndex(of: curIndex)

            if heap[curIndex] < heap[superIndex] {
                heap.swapAt(curIndex, superIndex)
                curIndex = superIndex
            } else {
                break
            }
        }
    }

    mutating func remove() -> Int? {
        guard !isEmpty else { return nil }

        heap.swapAt(0, heap.count - 1)
        let removedValue = heap.removeLast()

        var curIndex = 0
        while true {
            let sub = subIndices(of: curIndex)
            let left = sub.left
            let right = sub.right

            if right < heap.count {
                let target = heap[left] < heap[right] ? left : right

                if heap[curIndex] < heap[target] {
                    heap.swapAt(curIndex, target)
                    curIndex = target
                } else {
                    break
                }
            } else if left < heap.count {
                if heap[curIndex] < heap[left] {
                    heap.swapAt(curIndex, left)
                    curIndex = left
                } else {
                    break
                }
            } else {
                break
            }
        }

        return removedValue
    }

    private func superIndex(of curIndex: Int) -> Int {
        return (curIndex + 1) / 2 - 1
    }

    private func subIndices(of curIndex: Int) -> (left: Int, right: Int) {
        let left = curIndex * 2 + 1
        let right = curIndex * 2 + 2

        return (left, right)
    }
}