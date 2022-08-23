import Foundation

let n = Int(readLine()!)!

var maxHeap = Heap(heapType: .max)
var minHeap = Heap(heapType: .min)
var answer = ""

for _ in 0..<n {
    let number = Int(readLine()!)!

    if maxHeap.isEmpty || maxHeap.count == minHeap.count { 
        maxHeap.insert(number) 
    } else {
        minHeap.insert(number)
    }

    if !maxHeap.isEmpty && !minHeap.isEmpty && maxHeap.first > minHeap.first {
        let max = maxHeap.remove()!
        let min = minHeap.remove()!

        maxHeap.insert(min)
        minHeap.insert(max)
    }

    answer += "\(maxHeap.first)\n"
}

print(answer)

// Heap
struct Heap {
    
    enum HeapType {
        case min
        case max
        
        func compare(_ lhs: Int, with rhs: Int) -> Bool {
            if self == .min { return lhs < rhs }
            else { return lhs > rhs }
        }
    }
    
    private var heap = [Int]()
    let heapType: HeapType

    var isEmpty: Bool { heap.isEmpty }
    var count: Int { heap.count }
    var first: Int { heap.first! }
    
    init(heapType: HeapType) {
        self.heapType = heapType
    }
    
    mutating func insert(_ value: Int) {
        heap.append(value)
        
        var currentIndex = heap.count - 1
        while currentIndex > 0 {
            let superNodeIndex = superNodeIndex(of: currentIndex)
            
            // compare로 비교
            if heapType.compare(heap[currentIndex], with: heap[superNodeIndex]) {
                heap.swapAt(currentIndex, superNodeIndex)
                currentIndex = superNodeIndex
            } else {
                break
            }
        }
    }
    
    mutating func remove() -> Int? {
        guard !heap.isEmpty else { return nil }
        
        heap.swapAt(0, heap.count - 1)
        
        let removedNode = heap.removeLast()
        
        var currentIndex = 0
        while true {
            let subNodeIndices = subNodeIndices(of: currentIndex)
            let left = subNodeIndices.left
            let right = subNodeIndices.right
            
            if right < heap.count { // 둘 다 존재하는 경우
                // compare로 비교
                let targetIndex = heapType.compare(heap[left], with: heap[right]) ? left : right
                
                if !swapIfNeeded(currentIndex: &currentIndex, targetIndex: targetIndex) { break }
            } else if left < heap.count { // 왼쪽만 존재하는 경우
                if !swapIfNeeded(currentIndex: &currentIndex, targetIndex: left) { break }
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
    
    private mutating func swapIfNeeded(currentIndex: inout Int, targetIndex: Int) -> Bool {
        // compare로 비교
        if !heapType.compare(heap[currentIndex], with: heap[targetIndex]) {
            heap.swapAt(currentIndex, targetIndex)
            currentIndex = targetIndex
            
            return true
        } else {
            return false
        }
    }
}
