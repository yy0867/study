import Foundation

let nm = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
let rcd = readLine()!.components(separatedBy: " ").map { Int($0)! }
var r = rcd[0], c = rcd[1], d = rcd[2]
var field = [[Int]]()

for _ in 0..<n {
    let row = readLine()!.components(separatedBy: " ").map { Int($0)! }
    field.append(row)
}

func solution() -> Int {
    let dir = [-1, 0, 1, 0, -1]
    let none = 0, wall = 1, cleaned = 2
    var count = 0

    func clean() {
        count += 1
        field[r][c] = cleaned
    }

    func left() -> Int {
        return (d + 3) % 4
    }

    func back() -> (r: Int, c: Int) {
        return (r - dir[d], c - dir[d + 1])
    }

    func isOutOfBounds(r: Int, c: Int) -> Bool {
        return r < 0 || r >= n || c < 0 || c >= n
    }

    func isAllBlocked() -> Bool {
        for d in 0...3 {
            let nextR = r + dir[d], nextC = c + dir[d + 1]

            if isOutOfBounds(r: nextR, c: nextC) { continue }
            if field[nextR][nextC] == none { return false }
        }
        return true
    }

    func search() -> Bool {
        if isAllBlocked() {
            let back = back()
            if isOutOfBounds(r: back.r, c: back.c) || field[back.r][back.c] == wall {
                return false
            } else {
                r = back.r
                c = back.c
                return search()
            }
        }

        d = left()
        let leftR = r + dir[d], leftC = c + dir[d + 1]

        if isOutOfBounds(r: leftR, c: leftC) || field[leftR][leftC] != none {
            return search()
        } else {
            r = leftR
            c = leftC
            return true
        }
    }

    while true {
        clean()

        if !search() { break }
    }

    return count
}

print(solution())