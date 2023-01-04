import Foundation

let n = Int(readLine()!)!
let seq = (0..<n).map { _ in Int(readLine()!)! }
var history = [String]()

func solution() {
    var stack = Stack()
    var last = 0
    
    for s in seq {
        if stack.top < s {
            for i in (last + 1)...s {
                stack.push(i)
            }
            last = s
            stack.pop()
        } else if stack.top == s {
            stack.pop()
        } else {
            print("NO")
            return
        }
    }

    for r in history {
        print(r)
    }
}

solution()

struct Stack {

    var stack = [Int]()
    var isEmpty: Bool { return stack.isEmpty }
    var top: Int { return stack.last ?? 0 }

    mutating func push(_ element: Int) {
        stack.append(element)
        history.append("+")
    }

    mutating func pop() {
        history.append("-")
        stack.removeLast()
    }
}