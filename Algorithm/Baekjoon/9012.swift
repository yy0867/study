import Foundation

let t = Int(readLine()!)!
let strings = (0..<t).map { _ in readLine()! }

func solution() {
    for string in strings {
        var stack = Stack<String>()
        var flag = false

        for c in string {
            if c == "(" {
                stack.push("(")
            } else {
                if stack.pop() == nil {
                    flag = true
                    break
                }
            }
        }

        if flag || !stack.stack.isEmpty {
            print("NO")
        } else {
            print("YES")
        }
    }
}

solution()

struct Stack<T> {

    var stack = [T]()

    mutating func push(_ element: T) {
        stack.append(element)
    }

    mutating func pop() -> T? {
        if stack.isEmpty { return nil }

        return stack.removeLast()
    }
}