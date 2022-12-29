import Foundation

let n = Int(readLine()!)!

var p = [Int64](repeating: 0, count: n + 2)
p[0] = 1
p[1] = 2

if n == 1 {
    print(1)
    exit(0)
}

for i in 2..<n {
    p[i] = (p[i - 1] + p[i - 2]) % 10007
}

print(p[n - 1])