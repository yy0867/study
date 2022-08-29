import Foundation

let operators = [
    "+": 1,
    "-": 1,
    "*": 2,
    "/": 2,
    "(": 0,
    ")": 0,
]

func solution(_ exp: [String]) -> String {
    var stack = Stack()
    var builder = ""

    for e in exp {
        guard let _ = operators[e] else {
            builder += e
            continue
        }

        if e == "(" {
            stack.push(e)
            continue
        }

        if e == ")" {
            while let pop = stack.pop(), pop != "(" {
                builder += pop
            }
            continue
        }

        if stack.isEmpty || operators[e]! > operators[stack.top]! {
            stack.push(e)
        } else {
            while let pop = stack.pop() {
                if pop == "(" { continue }
                builder += pop
                if stack.isEmpty || operators[e]! > operators[stack.top]! {
                    stack.push(e)
                    break
                }
            }
        }
    }

    while let pop = stack.pop() {
        if pop == "(" { continue }
        builder += pop
    }

    return builder
}

let exp = readLine()!.map { String($0) }

print(solution(exp))

// Stack
struct Stack {

    var stack = [String]()
    
    var top: String { stack.last! }
    var isEmpty: Bool { stack.isEmpty }
    var count: Int { stack.count }

    mutating func push(_ element: String) {
        stack.append(element)
    }

    mutating func pop() -> String? {
        if isEmpty { return nil }
        return stack.removeLast()
    }
}
