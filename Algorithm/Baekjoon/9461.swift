import Foundation

let t = Int(readLine()!)!
let ns = (0..<t).map { _ in Int(readLine()!)! }
var d = [Int](repeating: 0, count: 101)

var last = 4
d[0] = 0
d[1] = 1
d[2] = 1
d[3] = 1
func p(_ n: Int) -> Int {
    if d[n] != 0 { return d[n] }

    for i in last...n {
        d[i] = d[i - 3] + d[i - 2]
    }

    last = n
    return d[n]
}

for n in ns {
    print(p(n))
}