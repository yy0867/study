import Foundation

let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0], k = nk[1]

func solution() -> Int {
    var queue = Queue<Int>()
    var visited = Set<Int>()
    var answer = 0

    queue.push(n)
    while !queue.isEmpty {
        for _ in 0..<queue.count {
            let node = queue.pop()

            if node == k { return answer }

            if node - 1 >= 0 && !visited.contains(node - 1) {
                visited.insert(node - 1)
                queue.push(node - 1)
            }
            if node + 1 <= 100000 && !visited.contains(node + 1) {
                visited.insert(node + 1)
                queue.push(node + 1)
            }
            if node * 2 <= 100000 && !visited.contains(node * 2) {
                visited.insert(node * 2)
                queue.push(node * 2)
            }
        }

        answer += 1
    }

    return answer
}

print(solution())

struct Queue<T> {

    var queue = [T]()
    var head = 0

    var isEmpty: Bool { head >= queue.count }
    var count: Int { queue.count - head }

    mutating func push(_ element: T) {
        queue.append(element)
    }

    mutating func pop() -> T {
        let value = queue[head]

        head += 1
        if head >= 5000 {
            queue.removeFirst(head)
            head = 0
        }

        return value
    }
}