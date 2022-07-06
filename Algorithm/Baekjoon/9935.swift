import Foundation

func solution(_ strings: [String], _ explode: [String]) -> String {
    var stack = [String]()

    for string in strings {
        stack.append(string)
        if string == explode.last! {
            if stack.count >= explode.count && Array(stack[(stack.count - explode.count)...]) == explode {
                for _ in 0..<explode.count {
                    stack.removeLast()
                }
            }
        }
    }

    return stack.isEmpty ? "FRULA" : stack.joined()
}

let strings = readLine()!.map { String($0) }
let explode = readLine()!.map { String($0) }

print(solution(strings, explode))
