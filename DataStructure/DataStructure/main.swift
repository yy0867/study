//
//  main.swift
//  DataStructure
//
//  Created by 김세영 on 2021/09/10.
//

import Foundation

func printLine(name: String) {
    print()
    for _ in 0 ..< 10 { print("-", terminator: "") }
    print(" \(name) ", terminator: "")
    for _ in 0 ..< 10 { print("-", terminator: "") }
    print("\n")
}

func queue() {
    printLine(name: "Queue")
    
    var queue = Queue<Int>()
    queue.enqueue(3)
    queue.enqueue(13)
    queue.enqueue(45)
    
    queue.print()
    
    print("dequeue() -> \(queue.dequeue()!)")
    queue.print()
    print("dequeue() -> \(queue.dequeue()!)")
    queue.print()
    print("dequeue() -> \(queue.dequeue()!)")
    queue.print()
}

func iqueue() {
    printLine(name: "Improved Queue")
    
    var iqueue = IQueue<String>()
    iqueue.enqueue("Hello")
    iqueue.enqueue("DataStructure")
    iqueue.enqueue("for Swift")
    
    iqueue.print()
    
    print("dequeue() -> \(iqueue.dequeue()!)")
    iqueue.print()
    print("dequeue() -> \(iqueue.dequeue()!)")
    iqueue.print()
    print("dequeue() -> \(iqueue.dequeue()!)")
    iqueue.print()
}

func stack() {
    printLine(name: "Stack")
    
    var stack = Stack<Int>()
    
    for i in 1...5 { stack.push(i) }
    stack.print()
    
    for _ in 1...5 {
        print("pop() -> \(stack.pop()!)")
        stack.print()
    }
}

func linkedList() {
    printLine(name: "Linked List")
    
    var list = LinkedList<String>()
    list.append("a")
    list.append("b")
    list.append("Linked")
    list.append("List")
    list.print()
    
    print("insert index[2]: Swift")
    list.insert("Swift", at: 2)
    list.print()
    
    print("insert index[2]: Hello")
    list.insert("Hello", at: 2)
    list.print()
    
    print("removeLast")
    list.removeLast()
    list.print()
    
    print("remove index[1] -> \(list.remove(at: 1))")
    list.print()
    
    print("removeLast X 3")
    for _ in 0 ..< 3 { list.removeLast() }
    list.print()
}

func heap() {
    printLine(name: "Heap")
    
    var heap = Heap<Int>()
    heap.type = .minHeap
    
    heap.insert(3)
    heap.insert(5)
    heap.insert(2)
    heap.insert(10)
    heap.insert(56)
    
    print("peek() -> \(heap.peek()!)")
    
    print("remove() -> \(heap.remove()!)")
    print("remove() -> \(heap.remove()!)")
    print("remove() -> \(heap.remove()!)")
    print("remove() -> \(heap.remove()!)")
    
    heap.print()
}

queue()
iqueue()
stack()
linkedList()
heap()
