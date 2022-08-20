import Foundation

func shift(_ field: [[Int]], to direction: Direction) -> [[Int]] {
    let n = field.count
    var result = [[Int]](repeating: [Int](repeating: 0, count: field.count), count: field.count)

    for i in 0..<n {
        var queue = Queue()

        switch direction {
            case .left:
                var cursor = -1
                for j in 0..<n where field[i][j] != 0 { queue.push(field[i][j]) }

                if queue.isEmpty { continue }

                while !queue.isEmpty {
                    let value = queue.pop()

                    if cursor == -1 || result[i][cursor] != value {
                        if cursor == -1 || result[i][cursor] != 0 { cursor += 1 }
                        result[i][cursor] = value
                    } else {
                        result[i][cursor] += value
                        cursor += 1
                    }
                }
            
            case .right:
                var cursor = n
                for j in stride(from: n - 1, through: 0, by: -1) where field[i][j] != 0 { queue.push(field[i][j]) }

                if queue.isEmpty { continue }

                while !queue.isEmpty {
                    let value = queue.pop()

                    if cursor == n || result[i][cursor] != value {
                        if cursor == n || result[i][cursor] != 0 { cursor -= 1 }
                        result[i][cursor] = value
                    } else {
                        result[i][cursor] += value
                        cursor -= 1
                    }
                }

            case .up:
                var cursor = -1
                for j in 0..<n where field[j][i] != 0 { queue.push(field[j][i]) }

                if queue.isEmpty { continue }

                while !queue.isEmpty {
                    let value = queue.pop()

                    if cursor == -1 || result[cursor][i] != value {
                        if cursor == -1 || result[cursor][i] != 0 { cursor += 1 }
                        result[cursor][i] = value
                    } else {
                        result[cursor][i] += value
                        cursor += 1
                    }
                }

            case .down:
                var cursor = n
                for j in stride(from: n - 1, through: 0, by: -1) where field[j][i] != 0 { queue.push(field[j][i]) }

                if queue.isEmpty { continue }

                while !queue.isEmpty {
                    let value = queue.pop()

                    if cursor == n || result[cursor][i] != value {
                        if cursor == n || result[cursor][i] != 0 { cursor -= 1 }
                        result[cursor][i] = value
                    } else {
                        result[cursor][i] += value
                        cursor -= 1
                    }
                }
        }
    }

    return result
}

func solution(_ n: Int, _ field: [[Int]]) -> Int {
    var max = 0

    func dfs(_ count: Int, _ shiftedField: [[Int]]) {
        if count >= 5 {
            let fieldMax = shiftedField.map { $0.max()! }.max()!
            max = fieldMax > max ? fieldMax : max
            return
        }

        for dir in Direction.allCases {
            dfs(count + 1, shift(shiftedField, to: dir))
        }
    }

    dfs(0, field)

    return max
}

let n = Int(readLine()!)!
var field = [[Int]]()

for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    field.append(row)
}

print(solution(n, field))

// Direction
enum Direction: CaseIterable {
    case up, down, left, right
}

// Queue
struct Queue {

    var queue = [Int]()
    var head = 0

    var isEmpty: Bool { head >= queue.count }

    mutating func push(_ element: Int) {
        queue.append(element)
    }

    mutating func pop() -> Int {
        let value = queue[head]
        head += 1

        if head > 1000 {
            queue.removeFirst(head)
            head = 0
        }

        return value
    }
}