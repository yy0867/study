import Foundation

let nmxyk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nmxyk[0], m = nmxyk[1], x = nmxyk[2], y = nmxyk[3], k = nmxyk[4]

var field = (0..<n).map { _ in readLine()!.split(separator: " ").map { Int($0)! } }
let moves = readLine()!.split(separator: " ").map { Int($0)! }

var dice = [
    [0, 2, 0],
    [4, 1, 3],
    [0, 5, 0],
    [0, 6, 0],
]

var numbers = [
    1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0,
]

func roll(_ dir: Int) {
    if dir == 1 { // east
        let temp = dice[3][1]
        dice[3][1] = dice[1][2]
        dice[1][2] = dice[1][1]
        dice[1][1] = dice[1][0]
        dice[1][0] = temp
    } else if dir == 2 { // west
        let temp = dice[3][1]
        dice[3][1] = dice[1][0]
        dice[1][0] = dice[1][1]
        dice[1][1] = dice[1][2]
        dice[1][2] = temp
    } else if dir == 3 { // north
        let temp = dice[0][1]
        dice[0][1] = dice[1][1]
        dice[1][1] = dice[2][1]
        dice[2][1] = dice[3][1]
        dice[3][1] = temp
    } else { // south
        let temp = dice[3][1]
        dice[3][1] = dice[2][1]
        dice[2][1] = dice[1][1]
        dice[1][1] = dice[0][1]
        dice[0][1] = temp
    }
}

func solution() -> [Int] {
    var answers = [Int]()
    var r = x, c = y
    let dr = [0, 0, 0, -1, 1]
    let dc = [0, 1, -1, 0, 0]

    for dir in moves {
        let nr = r + dr[dir]
        let nc = c + dc[dir]
        if nr < 0 || nr >= n || nc < 0 || nc >= m { continue }

        r = nr
        c = nc
        roll(dir)

        if field[r][c] == 0 {
            field[r][c] = numbers[dice[3][1]]!
        } else {
            numbers[dice[3][1]] = field[r][c]
            field[r][c] = 0
        }
        answers.append(numbers[dice[1][1]]!)
    }

    return answers
}

let answer = solution()

for r in answer {
    print(r)
}