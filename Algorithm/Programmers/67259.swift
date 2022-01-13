import Foundation

func solution(_ board:[[Int]]) -> Int {
	
	let n = board.count, straight = 100, corner = 600
	let dir = [-1, 0, 1, 0, -1] // up, right, down, left
	var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
	var minimumBoard = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: n)
	var minimumCost = Int.max
	
	func findRoute(_ dirCome: Int, r: Int, c: Int, cost: Int) {
		if r < 0 || r >= n || c < 0 || c >= n || visited[r][c] || board[r][c] == 1 || minimumBoard[r][c] < cost - 1000 { return }
		minimumBoard[r][c] = cost
		if r == n - 1 && c == n - 1 {
			minimumCost = cost < minimumCost ? cost : minimumCost
			return
		}
	
		
		func next(i: Int) {
			var addingCost = corner
			if i == dirCome { addingCost = straight }
			
			visited[r][c] = true
			findRoute(i, r: r + dir[i], c: c + dir[i + 1], cost: cost + addingCost)
		}
		
//		func printMinimumBoard() {
//			print("#######\(r), \(c)#######")
//			for min in minimumBoard {
//				let printer = min.map { $0 == Int.max ? 0 : $0 }
//				for p in printer {
//					let pr = NSString(format: "%5d", p)
//					print(pr, terminator: ", ")
//				}
//				print()
//			}
//		}
		
		next(i: dirCome)
		for i in 0 ..< 4 where i != dirCome {
//			printMinimumBoard()
			next(i: i)
		}
		visited[r][c] = false
	}
	
	for i in 0 ..< 4 {
		findRoute(i, r: dir[i], c: dir[i + 1], cost: 100)
	}
	
    return minimumCost
}

print(solution([
	[0, 1, 1, 1, 1, 1, 1, 1, 1],
	[0, 0, 0, 0, 0, 1, 1, 1, 1],
	[1, 1, 1, 1, 0, 1, 1, 1, 1],
	[0, 0, 0, 0, 0, 1, 1, 1, 1],
	[0, 1, 0, 1, 1, 1, 1, 1, 1],
	[0, 1, 0, 0, 0, 1, 1, 1, 1],
	[0, 1, 1, 1, 0, 1, 1, 1, 1],
	[0, 0, 0, 0, 0, 1, 1, 1, 1],
	[1, 1, 1, 1, 0, 0, 0, 0, 0]]))
//print(solution([
//	[0,0,0,0,0,0,0,1],
//	[0,0,0,0,0,0,0,0],
//	[0,0,0,0,0,1,0,0],
//	[0,0,0,0,1,0,0,0],
//	[0,0,0,1,0,0,0,1],
//	[0,0,1,0,0,0,1,0],
//	[0,1,0,0,0,1,0,0],
//	[1,0,0,0,0,0,0,0]]))
//print(solution([
//	[0,0,1,0],
//	[0,0,0,0],
//	[0,1,0,1],
//	[1,0,0,0]]))
//print(solution([
//	[0,0,0,0,0,0],
//	[0,1,1,1,1,0],
//	[0,0,1,0,0,0],
//	[1,0,0,1,0,1],
//	[0,1,0,0,0,1],
//	[0,0,0,0,0,0]]))