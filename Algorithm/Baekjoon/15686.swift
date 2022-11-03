import Foundation

typealias Point = (r: Int, c: Int)

let nm = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
let none = 0, home = 1, chicken = 2
var houses = [Point]()
var chickens = [Point]()

for i in 0..<n {
    readLine()!.components(separatedBy: " ").enumerated().forEach { (j, input) in
        let input = Int(input)!
        if input == none { 
            return 
        } else if input == home {
            houses.append((i, j))
        } else {
            chickens.append((i, j))
        }
    }
}

var opened = [Point]()
var answer = 999999999

func dist(_ src: Point, _ dest: Point) -> Int {
    return abs(src.r - dest.r) + abs(src.c - dest.c)
}

func minChickenDist() -> Int {
    var result = 0

    for house in houses {
        var minDist = 999999999
        for chicken in opened {
            let dist = dist(house, chicken)
            minDist = dist < minDist ? dist : minDist
        }
        result += minDist
    }

    return result
}

func combination(_ index: Int, _ count: Int) {
    if count == m {
        let minDist = minChickenDist()
        answer = minDist < answer ? minDist : answer
        return
    }

    for i in (index + 1)..<chickens.count {
        opened.append(chickens[i])
        combination(i, count + 1)
        opened.removeLast()
    }
}

for i in 0...(chickens.count - m) {
    opened.append(chickens[i])
    combination(i, 1)
    opened.removeLast()
}

print(answer)