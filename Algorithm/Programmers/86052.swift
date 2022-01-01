import Foundation

func generateMap(by grid: [String]) -> [[[Bool]]] {
	var map = [[[Bool]]]()
	
	for row in grid {
		var curRow = [[Bool]]()
		for _ in row {
			curRow.append([false, false, false, false])
		}
		map.append(curRow)
	}
	
	return map
}

func getLeftDir(of curDir: Int) -> Int { return (curDir + 3) % 4 }
func getRightDir(of curDir: Int) -> Int { return (curDir + 1) % 4 }
func getStraightDir(of curDir: Int) -> Int { return curDir }

func solution(_ grid: [String]) -> [Int] {
	
	let R = grid.count, C = grid[0].count
	let dir = [-1, 0, 1, 0, -1] // 0: up, 1: right, 2: down, 3: left
	let compactGrid = grid.map { $0.map { String($0) } }
	var resultWeight = [Int]()
	var isVisit = generateMap(by: grid)
	
	for (r, visitRow) in isVisit.enumerated() {
		for (c, _) in visitRow.enumerated() {
			// start coordination
			var row = r, col = c
			
			// start path finding
			for dirPoint in 0...3 {
				
				var curDir = dirPoint
				var weight = 0
				// check the [row][col] was already visited
				if isVisit[row][col][dirPoint] { continue }
				
				// start path
				while !isVisit[row][col][curDir] {
					isVisit[row][col][curDir] = true
					
					if curDir == 1 || curDir == 2 {
						// calculate next row, col if dir is right / down (+)
						row = (row + dir[curDir]) % R
						col = (col + dir[curDir + 1]) % C
					} else {
						// calculate next row, col if dir is left / up (-)
						row = (row + R + dir[curDir]) % R
						col = (col + C + dir[curDir + 1]) % C
					}
					
					if compactGrid[row][col] == "S" { curDir = getStraightDir(of: curDir) }
					else if compactGrid[row][col] == "L" { curDir = getLeftDir(of: curDir) }
					else if compactGrid[row][col] == "R" { curDir = getRightDir(of: curDir) }
					
					weight += 1
				}
				
				resultWeight.append(weight)
			}
		}
	}
	
	return resultWeight.sorted()
}

print(solution(["SL", "LR"]))
print(solution(["S"]))
print(solution(["R", "R"]))