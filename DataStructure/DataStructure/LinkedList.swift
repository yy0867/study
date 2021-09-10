//
//  LinkedList.swift
//  DataStructure
//
//  Created by 김세영 on 2021/09/10.
//

import Foundation

// MARK: - Linked List
// 연결 리스트의 노드를 정의
class Node<T> {
    
    // 해당 노드의 값
    var value: T
    // 해당 노드가 가리키는 다음 노드
    var next: Node?
    
    init(_ value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

struct LinkedList<T>: DataStructure {
    
    // 연결 리스트의 첫 노드를 가리키는 프로퍼티
    // 연결 리스트에 노드가 없다면 `nil`이므로, 옵셔널로 선언
    private var head: Node<T>?
    
    // DataStructure 프로토콜 준수
    var isEmpty: Bool { head == nil }
    var count: Int {
        if isEmpty { return 0 }
        
        var node = head
        var count = 0
        while node?.next != nil {
            node = node?.next
            count += 1
        }
        
        return count
    }
    
    func print() {
        if isEmpty {
            Swift.print("Empty Linked List")
            return
        }
        
        var node = head
        while node?.next != nil {
            Swift.print("\(node!.value) -> ", terminator: "")
            node = node?.next
        }
        Swift.print("\(node!.value) -> ", terminator: "")
        Swift.print()
    }
    
    // `append(_:)`
    // 연결 리스트의 끝에 값을 추가하는 메서드
    // `head`에서 Node의 `next`가 `nil`일 때까지 탐색하고,
    // `nil`을 만나면 그 자리에 입력 값을 가지는 노드를 추가함.
    mutating func append(_ element: T) {
        if isEmpty {
            head = Node(element)
            return
        }
        
        var node = head
        while node?.next != nil {
            node = node?.next
        }
        node?.next = Node(element)
    }
    
    // `insert(_:at:)`
    // 연결 리스트의 원하는 인덱스에 값을 추가하는 메서드
    // `index`만큼 `next`를 탐색하고, 그 자리에 입력 값을 가지는 노드를 추가함.
    // 새로 생성한 노드에는 기존 노드의 `next`를 연결해 줌.
    // 만약 `index`가 연결 리스트의 범위를 벗어난다면, `append(_:)`처럼 기능
    mutating func insert(_ element: T, at index: Int) {
        if isEmpty {
            head = Node(element)
            return
        }
        
        var node = head
        for _ in 0 ..< (index - 1) {
            if node?.next == nil { break }
            node = node?.next
        }
        
        let prevNext = node?.next
        node?.next = Node(element)
        node?.next?.next = prevNext
    }
    
    // `removeLast() -> T?`
    // 연결 리스트의 가장 마지막 노드를 삭제
    // 마지막 노드의 전까지 탐색하고, 그 때 `next`를 `nil`로 만듦
    // 연결 리스트가 비어 있다면 `nil`을 반환하므로 반환 형태를 옵셔널로 선언
    mutating func removeLast() -> T? {
        if isEmpty { return nil }
        
        var node = head
        // 마지막 노드의 전까지만 탐색해야 하므로,
        // `next`를 두 번 참조
        while node?.next?.next != nil {
            node = node?.next
        }
        
        let element = node?.next?.value
        node?.next = nil
        
        return element
    }
    
    // `remove(at:) -> T?`
    // 연결 리스트에서 원하는 인덱스의 값을 삭제
    // 원하는 인덱스가 범위를 넘어가거나 리스트가 비어 있다면 `nil`을 반환하므로, 옵셔널로 정의
    // 삭제할 노드의 이전 노드의 `next`를, 삭제할 노드의 다음 노드를 가리키게 함.
    mutating func remove(at index: Int) -> T? {
        if isEmpty { return nil }
        
        var node = head
        for _ in 0 ..< (index - 1) {
            if node?.next == nil { return nil }
            node = node?.next
        }
        
        let element = node?.next?.value
        node?.next = node?.next?.next
        
        return element
    }
}
