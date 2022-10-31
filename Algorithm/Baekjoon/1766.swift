import Foundation

let nm = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var graph = [[Int]](repeating: [], count: n + 1)
var inDegree = [Int](repeating: 0, count: n + 1)

for _ in 0..<m {
    let edge = readLine()!.components(separatedBy: " ").map { Int($0)! }
    graph[edge[0]].append(edge[1])
    inDegree[edge[1]] += 1
}

func solution() {
    var pq = PriorityQueue<Int>()

    for i in 1...n {
        if inDegree[i] == 0 { pq.push(i) }
    }

    while let node = pq.pop() {

        print(node, terminator: " ")

        for dest in graph[node] {
            inDegree[dest] -= 1

            if inDegree[dest] == 0 {
                pq.push(dest)
            }
        }
    }
}

solution()

struct PriorityQueue<Value> where Value: Comparable {
    
    private var heap = Heap<Value>()

    var isEmpty: Bool { return heap.isEmpty }
    
    mutating func push(_ value: Value) {
        heap.insert(value)
    }
    
    mutating func pop() -> Value? {
        return heap.remove()?.value
    }
}

struct Node<Value>: Comparable where Value: Comparable {
    let value: Value
    
    static func < (lhs: Node, rhs: Node) -> Bool {
        return lhs.value < rhs.value
    }
}

struct Heap<Value> where Value: Comparable {
    
    // 각 노드를 저장할 배열
    private var heap = [Node<Value>]()
    
    var isEmpty: Bool { return heap.isEmpty }
    
    mutating func insert(_ value: Value) {
        let node = Node(value: value)
        heap.append(node)
        
        // sift up
        var currentIndex = heap.count - 1
        while currentIndex > 0 {
            let superNodeIndex = superNodeIndex(of: currentIndex)
            
            if heap[currentIndex] < heap[superNodeIndex] {
                heap.swapAt(currentIndex, superNodeIndex)
                currentIndex = superNodeIndex
            } else {
                break
            }
        }
    }
    
    mutating func remove() -> Node<Value>? {
        guard !heap.isEmpty else { return nil }
        
        heap.swapAt(0, heap.count - 1)
        
        let removedNode = heap.removeLast()
        
        // sift down
        var currentIndex = 0
        while true {
            let subNodeIndices = subNodeIndices(of: currentIndex)
            let left = subNodeIndices.left
            let right = subNodeIndices.right
            
            if right < heap.count { // 둘 다 존재하는 경우
                let targetIndex = heap[left] < heap[right] ? left : right
                
                if !swapIfGreaterThan(currentIndex: &currentIndex, targetIndex: targetIndex) { break }
            } else if left < heap.count { // 왼쪽만 존재하는 경우
                if !swapIfGreaterThan(currentIndex: &currentIndex, targetIndex: left) { break }
            } else { // 둘 다 없는 경우
                break
            }
        }
        
        return removedNode
    }
    
    private func superNodeIndex(of currentIndex: Int) -> Int {
        return (currentIndex + 1) / 2 - 1
    }
    
    private func subNodeIndices(of currentIndex: Int) -> (left: Int, right: Int) {
        let left = currentIndex * 2 + 1
        let right = currentIndex * 2 + 2
        
        return (left, right)
    }
    
    private mutating func swapIfGreaterThan(currentIndex: inout Int, targetIndex: Int) -> Bool {
        if heap[currentIndex] > heap[targetIndex] {
            heap.swapAt(currentIndex, targetIndex)
            currentIndex = targetIndex
            
            return true
        } else {
            return false
        }
    }
}