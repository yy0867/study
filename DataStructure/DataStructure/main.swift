//
//  main.swift
//  DataStructure
//
//  Created by 김세영 on 2021/09/10.
//

import Foundation

func printLine(name: String) {
    for _ in 0 ..< 10 { print("-", terminator: "") }
    print(" \(name) ", terminator: "")
    for _ in 0 ..< 10 { print("-", terminator: "") }
    print()
}

func queue() {
    printLine(name: "Queue")
    
    var queue = Queue<Int>()
    queue.enqueue(3)
    queue.enqueue(13)
    queue.enqueue(45)
    
    print(queue)
    
    print("dequeue() -> \(queue.dequeue()!)")
    print("dequeue() -> \(queue.dequeue()!)")
    print("dequeue() -> \(queue.dequeue()!)")
}

func iqueue() {
    printLine(name: "Improved Queue")
    
    var iqueue = IQueue<String>()
    iqueue.enqueue("Hello")
    iqueue.enqueue("DataStructure")
    iqueue.enqueue("for Swift")
    
    print(iqueue)
    
    print("dequeue() -> \(iqueue.dequeue()!)")
    print("dequeue() -> \(iqueue.dequeue()!)")
    print("dequeue() -> \(iqueue.dequeue()!)")
}

func stack() {
    printLine(name: "Stack")
    
    var stack = Stack<Int>()
    
    for i in 1...5 { stack.push(i) }
    print(stack)
    
    for _ in 1...5 { print("pop() -> \(stack.pop()!)") }
}

queue()
iqueue()
stack()
