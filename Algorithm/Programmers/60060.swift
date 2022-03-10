import Foundation

class Node {
	let word: String
	var subNodes = [String: Node]()
	var subCount: Int = 0

	init(word: String) {
		self.word = word
	}
}

class Trie {
	let root: Node

	init() { self.root = Node(word: "") }

	func insert(_ word: String) {
		var curNode = root
		for char in word {
			let ch = String(char)
			curNode.subCount += 1
			if curNode.subNodes[ch] == nil {
				curNode.subNodes[ch] = Node(word: ch)
			}
			curNode = curNode.subNodes[ch]!
		}
	}

	func getCount(of query: String) -> Int {
		var curNode = root
		for char in query {
			let ch = String(char)
			if ch == "?" { return curNode.subCount }
			if curNode.subNodes[ch] == nil { return 0 }
			curNode = curNode.subNodes[ch]!
		}
		return curNode.subCount
	}
}

func solution(_ words:[String], _ queries:[String]) -> [Int] {
	var regularWordTrie = [Int: Trie]()
	var reverseWordTrie = [Int: Trie]()
	var answer = [Int]()

	for word in words {
		let count = word.count
		if regularWordTrie[count] == nil { regularWordTrie.updateValue(Trie(), forKey: count) }
		if reverseWordTrie[count] == nil { reverseWordTrie.updateValue(Trie(), forKey: count) }
		regularWordTrie[count]!.insert(word)
		reverseWordTrie[count]!.insert(String(word.reversed()))
	}

	for query in queries {
		var count = 0
		if regularWordTrie[query.count] == nil { count = 0 }
		else if query.first! == "?" { count = reverseWordTrie[query.count]!.getCount(of: String(query.reversed())) }
		else { count = regularWordTrie[query.count]!.getCount(of: query) }
		answer.append(count)
	}

    return answer
}

print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["??????", "??????", "?????", "fro??", "????o", "fr???", "fro???", "pro?"]))


