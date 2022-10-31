import Foundation

let lc = readLine()!.components(separatedBy: " ").map { Int($0)! }
let l = lc[0], c = lc[1]
let letters = readLine()!.components(separatedBy: " ").sorted(by: <)

func solution() {
    var mo = 0, ja = 0

    func combination(_ index: Int, _ curLetters: String) {
        if curLetters.count == l {
            if ja >= 2 && mo >= 1 {
                print(curLetters)
            }
            return
        }

        for i in (index + 1)..<c {
            var isMo = false
            if moeum.contains(letters[i]) {
                mo += 1
                isMo = true
            } else {
                ja += 1
            }
            combination(i, curLetters + letters[i])
            if isMo {
                mo -= 1
            } else {
                ja -= 1
            }
        }
    }

    for i in 0...(c - l) {
        var isMo = false
        if moeum.contains(letters[i]) {
            mo += 1
            isMo = true
        } else {
            ja += 1
        }
        combination(i, letters[i])
        if isMo {
            mo -= 1
        } else {
            ja -= 1
        }
    }
}

let moeum: Set<String> = ["a", "e", "i", "o", "u"]
solution()