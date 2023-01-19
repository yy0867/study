import Foundation

let n = Int(readLine()!)!
var stack = [Int]()

for _ in 0..<n {
    let op = readLine()!.split(separator: " ")

    if op[0] == "push" {
        stack.append(Int(op[1])!)
    } else if op[0] == "pop" {
        if stack.isEmpty {
            print(-1)
        } else {
            print(stack.removeLast())
        }
    } else if op[0] == "size" {
        print(stack.count)
    } else if op[0] == "empty" {
        print(stack.isEmpty ? 1 : 0)
    } else { // top
        if stack.isEmpty {
            print(-1)
        } else {
            print(stack.last!)
        }
    }
}