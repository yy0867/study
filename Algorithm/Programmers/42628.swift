import Foundation

func solution(_ operations:[String]) -> [Int] {
    
    var heap = [Int]()
    
    func makeHeap(_ element: Int) {
        if heap.isEmpty { heap.append(element); return }
        
        var start = 0, end = heap.count - 1
        
        while start <= end {
            let mid = (start + end) / 2
            let comp = heap[mid]
            
            if element < comp {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        heap.insert(element, at: start)
    }
    
    for op in operations {
        let split = op.split(separator: " ")
        let command = split.first!
        let number = Int(split.last!)!
        
        if command == "I" {
            makeHeap(number)
        } else {
            if heap.isEmpty { continue }
            if number == 1 {
                heap.removeLast()
            } else {
                heap.removeFirst()
            }
        }
    }
    
    var answer = [0, 0]
    
    if !heap.isEmpty {
        answer = [heap.max()!, heap.min()!]
    }
    
    return answer
}

print(solution(["I 7","I 5","I -5","D -1"]))
print(solution(["I 16", "D 1"]))