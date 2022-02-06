import Foundation

class Node: Equatable {
    let index: Int64
    var value: Int64
    var connectedNodes = [Node]()

    init(index: Int64, value: Int64) {
        self.index = index
        self.value = value
    }

    func connectNode(_ node: Node) {
        connectedNodes.append(node)
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.index == rhs.index && lhs.value == rhs.value
    }
}

func solution(_ a:[Int], _ edges:[[Int]]) -> Int64 {
    if (a.reduce(0) { $0 + $1 }) != 0 { return -1 }
    
    var nodes = [Node]()
    for (index, value) in a.enumerated() { 
        let index64 = Int64(index)
        let value64 = Int64(value)
        nodes.append(.init(index: index64, value: value64)) 
    }

    for edge in edges {
        let node1 = nodes[edge[0]], node2 = nodes[edge[1]]
        node1.connectNode(node2)
        node2.connectNode(node1)
    }

    var answer: Int64 = 0
    func makeSubtreeZero(_ superNode: Node, _ subNode: Node) {
        for node in subNode.connectedNodes where node != superNode {
            makeSubtreeZero(subNode, node)

            let count = node.value
            node.value -= count
            subNode.value += count
            answer += abs(count)
        }
    }

    for subNode in nodes[0].connectedNodes {
        makeSubtreeZero(nodes[0], subNode)
        let count = subNode.value
        subNode.value -= count
        nodes[0].value += count
        answer += abs(count)
    }

    return answer
}

print(solution([-5,0,2,1,2], [[0,1],[3,4],[2,3],[0,3]]))
print(solution([0,1,0], [[0,1],[1,2]]))
print(solution([-2, 8, -5, -5, -3, 0, 5, 2], [[0, 1], [0, 2], [1, 3], [1, 4], [1, 5], [2, 6], [2, 7]]))

    // for node in nodes {
    //     print("node: \(node.index) - \(node.value)")
    //     print("connectedNodes: ", terminator: "")
    //     for con in node.connectedNodes {
    //         print("[\(con.index) - \(con.value)]", terminator: ", ")
    //     }
    //     print()
    // }