import Foundation

class Node {
    let value: Int
    var right: Node?
    var left: Node?

    init(value: Int) {
        self.value = value
    }
}

func solution(_ nodeinfo:[[Int]]) -> [[Int]] {

    var nodeInfoWithLevel = [Int : [[Int]]]()
    var levelSet = Set<Int>()
    var maxX = -1

    for (index, node) in nodeinfo.enumerated() {
        let info = [node[0], node[1], index + 1]
        levelSet.insert(node[1])
        maxX = node[0] > maxX ? node[0] : maxX

        if nodeInfoWithLevel[node[1]] == nil {
            nodeInfoWithLevel.updateValue([], forKey: node[1])
        }
        nodeInfoWithLevel[node[1]]!.append(info)
    }

    let level = Array(levelSet).sorted(by: >)
    
    func buildBinaryTree(_ start: Int, _ sep: Int, _ end: Int, _ indexOfLevel: Int, _ node: Node?) {
        guard let node = node, indexOfLevel < level.count else { return }
        let curLevel = level[indexOfLevel]

        let nodesOfLevel = nodeInfoWithLevel[curLevel]!
        for curNode in nodesOfLevel {
            let newNode = Node(value: curNode[2])
            if start <= curNode[0] && curNode[0] < sep {
                node.left = newNode
                // left
                buildBinaryTree(start, curNode[0], sep - 1, indexOfLevel + 1, newNode)
            } else if sep < curNode[0] && curNode[0] <= end {
                node.right = newNode
                // right
                buildBinaryTree(sep + 1, curNode[0], end, indexOfLevel + 1, newNode)
            }
        }
    }
    
    let rootInfo = nodeInfoWithLevel[level.first!]!.first!
    let rootNode = Node(value: rootInfo[2])

    buildBinaryTree(0, rootInfo[0], maxX, 1, rootNode)
    var preOrder = [Int]()
    var postOrder = [Int]()

    func generatePreOrder(_ node: Node?) {
        guard let node = node else { return }
        preOrder.append(node.value)
        generatePreOrder(node.left)
        generatePreOrder(node.right)
    }

    func generatePostOrder(_ node: Node?) {
        guard let node = node else { return }
        generatePostOrder(node.left)
        generatePostOrder(node.right)
        postOrder.append(node.value)
    }

    generatePreOrder(rootNode)
    generatePostOrder(rootNode)

    return [preOrder, postOrder]
}

print(solution([[5,3],[11,5],[13,3],[3,5],[6,1],[1,3],[8,6],[7,2],[2,2]]))