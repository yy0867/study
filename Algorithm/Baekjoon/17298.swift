import Foundation

let n = Int(readLine()!)!
let seq = readLine()!.split(separator: " ").map { Int($0)! }

var stack = Stack()
var answer = [Int](repeating: 0, count: n)

for i in stride(from: n - 1, through: 0, by: -1) {
    while !stack.isEmpty && stack.top <= seq[i] {
        _ = stack.pop()
    }

    if stack.isEmpty {
        answer[i] = -1
    } else {
        answer[i] = stack.top
    }

    stack.push(seq[i])
}

for num in answer {
    print(num, terminator: " ")
}

struct Stack {

    var stack = [Int]()

    var count: Int { stack.count }
    var isEmpty: Bool { stack.isEmpty }
    var top: Int { stack.last! }

    mutating func push(_ element: Int) {
        stack.append(element)
    }

    mutating func pop() -> Int {
        return stack.removeLast()
    }
}