import Foundation

func solution(_ tickets:[[String]]) -> [String] {
    let sortedTicktes = tickets.sorted { lhs, rhs in 
        if lhs[0] != rhs[0] { return lhs[0] < rhs[0] }
        return lhs[1] < rhs[1]
    }

    var visited = [Bool](repeating: false, count: tickets.count)
    var answer = ["ICN"]

    @discardableResult
    func findRoute(_ start: String, _ count: Int) -> Bool {

        // tickets all used
        if count == sortedTicktes.count { return true }

        for (i, ticket) in sortedTicktes.enumerated() {
            if visited[i] || ticket[0] != start { continue }

            visited[i] = true
            answer.append(ticket[1])

            if findRoute(ticket[1], count + 1) { return true }
            visited[i] = false
        }
        answer.removeLast()
        return false
    }

    findRoute("ICN", 0)

    return answer
}

print(solution([["ICN", "AOO"], ["AOO", "BOO"], ["BOO", "COO"], ["COO", "DOO"], ["DOO", "EOO"], ["EOO", "DOO"], ["DOO", "COO"], ["COO", "BOO"], ["BOO", "AOO"]]))