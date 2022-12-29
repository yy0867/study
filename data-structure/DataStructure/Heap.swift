//
//  Heap.swift
//  DataStructure
//
//  Created by 김세영 on 2021/09/12.
//

import Foundation

struct Heap<T: Comparable>: DataStructure {
    init() { self.type = .maxHeap }
    
    // minHeap, maxHeap 여부
    enum HeapType: Int {
        case minHeap = 0
        case maxHeap
    }
    var type: HeapType {
        didSet {
            if self.type == .maxHeap {
                Swift.print("maxHeap입니다.")
            } else {
                Swift.print("minHeap입니다.")
            }
        }
    }
    
    // 힙을 구성하는 완전 이진 트리를 배열로 구성
    var heap = [T]()
    
    // DataStructure 프로토콜 준수
    var count: Int { heap.count }
    var isEmpty: Bool { heap.isEmpty }
    
    func print() {
        Swift.print(heap)
    }
    
    // 한 노드의 왼쪽, 오른쪽 자식 노드의 번호
    private func leftChild(of index: Int) -> Int { return index * 2 + 1 }
    private func rightChild(of index: Int) -> Int { return index * 2 + 2 }
    // 부모 노드의 번호
    private func parent(of index: Int) -> Int {
        if index == 0 { return 0 }
        return (index - 1) / 2
    }
    
    // `compare(child:parent:) -> Bool`
    // child와 parent를 비교해, `HeapType`에 맞는 값을 반환
    private func compare(child: Int, parent: Int) -> Bool {
        // minHeap일 경우 부모 노드의 값이 항상 작아야 함
        if type == .minHeap { return heap[child] < heap[parent] }
        // maxHeap일 경우 부모 노드의 값이 항상 커야 함
        else { return heap[child] > heap[parent] }
    }
    
    // `peek() -> T?`
    // 루트 노드를 반환하는 메서드
    // 힙이 비어 있다면 `nil`을 반환
    func peek() -> T? {
        return heap.first
    }
    
    // `insert(_:)`
    // 힙에 데이터를 삽입하는 메서드
    mutating func insert(_ element: T) {
        heap.append(element)
        siftUp(from: heap.count - 1)
    }
    
    // `siftUp(from:)`
    // 받은 인자로부터 위로 올라가면서
    // 힙을 구성해주는 메서드
    private mutating func siftUp(from index: Int) {
        var parent = parent(of: index), child = index
        
        while child > 0 && compare(child: child, parent: parent) {
            heap.swapAt(child, parent)
            child = parent
            parent = self.parent(of: parent)
        }
    }
    
    // `remove() -> T?`
    // 힙의 첫 번째 원소 (가장 크거나 작은 값)을 반환 후 힙을 재구성
    // 힙이 비어 있다면 `nil`을 반환
    mutating func remove() -> T? {
        guard !isEmpty else { return nil }
        
        heap.swapAt(0, heap.count - 1)
        let item = heap.removeLast()
        siftDown(from: 0)
        
        return item
    }
    
    private mutating func siftDown(from index: Int) {
        var parent = index, next = index
        
        repeat {
            let left = leftChild(of: parent)
            let right = rightChild(of: parent)
            
            // 오른쪽 자식이 없는 경우
            if right >= count {
                // 왼쪽 자식도 없다면 바로 종료
                if left >= count { return }
                // 왼쪽 자식이 있다면, 비교 상대는 왼쪽 자식
                else { next = left }
            }
            // 위에서 자식 노드가 없는 경우는 모두 걸러 주었으므로
            // 자식 둘이 모두 있는 경우가 됨
            else {
                // maxHeap일 경우, 두 자식 중 더 큰 자식 노드가 비교 대상
                // minHeap일 경우, 두 자식 중 더 작은 자식 노드가 비교 대상
                if type == .maxHeap {
                    next = heap[left] > heap[right] ? left : right
                } else {
                    next = heap[left] < heap[right] ? left : right
                }
            }
            
            // 비교 대상과 부모 노드를 비교 후,
            // 조건에 맞다면 두 노드를 바꿔 줌
            if compare(child: next, parent: parent) {
                heap.swapAt(next, parent)
                parent = next
            }
            
        } while next != parent
    }
}
