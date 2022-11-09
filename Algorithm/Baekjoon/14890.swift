import Foundation

let nl = readLine()!.split(separator: " ").map { Int($0)! }
let n = nl[0], l = nl[1]
var field = [[Int]]()

for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    field.append(row)
}

var answer = 0

// down
for j in 0..<n {
    var last = field[0][j]
    var count = 1
    var isChecking = false
    var isConnected = true

    for i in 1..<n {
         if isChecking && count >= l {
            isChecking = false
            count = 0
        }

        if field[i][j] == last {
            last = field[i][j]
            count += 1
            continue
        } else if abs(field[i][j] - last) == 1 {
            if isChecking { 
                isConnected = false
                break 
            }
            if field[i][j] > last { // upper
                if count >= l {
                    last = field[i][j]
                    count = 1
                    continue
                } else {
                    isConnected = false
                    break
                }
            } else { // lower
                isChecking = true
                last = field[i][j]
                count = 1
            }
        } else {
            isConnected = false
            break
        }
    }

    if isConnected {
        if isChecking && count < l { continue }
        answer += 1
    }
}

// right
for i in 0..<n {
    var last = field[i][0]
    var count = 1
    var isChecking = false
    var isConnected = true

    for j in 1..<n {
        if isChecking && count >= l {
            isChecking = false
            count = 0
        }

        if field[i][j] == last {
            last = field[i][j]
            count += 1
            continue
        } else if abs(field[i][j] - last) == 1 {
            if isChecking { 
                isConnected = false
                break 
            }
            if field[i][j] > last { // upper
                if count >= l {
                    last = field[i][j]
                    count = 1
                    continue
                } else {
                    isConnected = false
                    break
                }
            } else { // lower
                isChecking = true
                last = field[i][j]
                count = 1
            }
        } else {
            isConnected = false
            break
        }
    }

    if isConnected {
        if isChecking && count < l { continue }
        answer += 1
    }
}

print(answer)