import Foundation

class Node {
    
    var left: Node?
    var right: Node?
    var index: Int
    
    init(left: Node? = nil, right: Node? = nil, index: Int) {
        self.left = left
        self.right = right
        self.index = index
    }
}

struct Table {
    
    private var head: Node?
    private var tail: Node?
    private var undoNodes = [Node]()
    var cursor: Node?
    
    init(head: Node) {
        self.head = head
        self.tail = head
        self.cursor = head
    }
    
    mutating func append(_ index: Int) {
        let node = Node(left: tail, index: index)
        tail?.right = node
        tail = node
    }
    
    mutating func moveUp(by distance: Int) {
        for _ in 0 ..< distance {
            cursor = cursor?.left
        }
    }
    
    mutating func moveDown(by distance: Int) {
        for _ in 0 ..< distance {
            cursor = cursor?.right
        }
    }
    
    mutating func delete() {
        undoNodes.append(cursor!)
        let right = cursor?.right
        let left = cursor?.left
        
        right?.left = left
        left?.right = right
        
        // not last node
        if right != nil {
            cursor = right
            if left == nil {
                head = cursor
            }
        } else {
            cursor = left
            tail = cursor
        }
    }
    
    mutating func undo() {
        let node = undoNodes.removeLast()
        
        node.left?.right = node
        node.right?.left = node
        
        if node.left == nil {
            head = node
        }
        if node.right == nil {
            tail = node
        }
    }
    
    func printList() {
        var printCursor = head
        print("\n\ncursor: \(cursor!.index)")
        while printCursor != nil {
            print("-\(printCursor!.index)-", terminator: "")
            printCursor = printCursor?.right
        }
    }
    
    func toAnswer() -> String {
        
        var answer = ""
        var answerCursor = head
        var order = 0
        while answerCursor != nil {
            if answerCursor!.index == order {
                answer += "O"
                answerCursor = answerCursor?.right
            } else {
                answer += "X"
            }
            order += 1
        }
        
        return answer
    }
}

func solution(_ n: Int, _ k: Int, _ cmd: [String]) -> String {
    var table = Table(head: Node(index: 0))
    var isDeleted = [false]
    for i in 1 ..< n {
        table.append(i)
        isDeleted.append(false)
    }
    
    table.moveDown(by: k)
    
    for command in cmd {
        
        if command.first! == "D" {
            table.moveDown(by: Int(command.split(separator: " ").last!)!)
        } else if command.first! == "U" {
            table.moveUp(by: Int(command.split(separator: " ").last!)!)
        } else if command == "C" {
            table.delete()
        } else {
            table.undo()
        }
//      table.printList()
    }
    
    var answer = table.toAnswer()
    if answer.count != n {
        for _ in 0 ..< n - answer.count {
            answer += "X"
        }
    }
    return answer
}

//print(solution(8, 2, ["D 2", "D 2", "C"]))
print(solution(8, 2, ["D 2","C","U 3","C","D 4","C","U 2","Z","Z"]))
print(solution(8, 2, ["D 2","C","U 3","C","D 4","C","U 2","Z","Z","U 1","C"]))