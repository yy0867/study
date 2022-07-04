import Foundation

func solution(_ functions: [String], _ array: [Int]) -> String {
    var dequeue = Dequeue(array)
    var isForward = true
    for f in functions {
        if f == "R" { isForward.toggle() }
        else {
            if isForward {
                if !dequeue.removeFirst() {
                    return "error"
                }
            } else {
                if !dequeue.removeLast() {
                    return "error"
                }
            }
        }
    }
    return dequeue.toString(fromHead: isForward)
}

let t = Int(readLine()!)!
var result = [String]()
for _ in 0..<t {
    let functions = readLine()!.map { $0 }.map { String($0) }
    let p = Int(readLine()!)!
    let array = parseArray(readLine()!)
    result.append(solution(functions, array))
}
for r in result {
    print(r)
}

func parseArray(_ string: String) -> [Int] {
    if string == "[]" { return [] }
    let base = string.dropFirst().dropLast().split(separator: ",").map { Int(String($0))! }
    return base
}

// Dequeue
struct Dequeue {
    var queue = [Int]()
    var head = 0
    var isEmpty: Bool { head >= queue.count }

    init(_ queue: [Int]) {
        self.queue = queue
    }

    mutating func removeFirst() -> Bool {
        if isEmpty { return false }
        head += 1
        return true
    }

    mutating func removeLast() -> Bool {
        if isEmpty { return false }
        queue.removeLast()
        return true
    }

    func toString(fromHead isForward: Bool) -> String {
        if isEmpty { return "[]" }
        var result = "["

        if isForward {
            for i in head..<queue.count {
                result.append("\(queue[i]),")
            }
        } else {
            for i in stride(from: queue.count - 1, through: head, by: -1) {
                result.append("\(queue[i]),")
            }
        }

        result.removeLast()
        result.append("]")
        return result
    }
}