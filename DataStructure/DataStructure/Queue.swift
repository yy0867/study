//
//  Queue.swift
//  DataStructure
//
//  Created by 김세영 on 2021/09/10.
//

import Foundation

// MARK: - Queue
struct Queue<T>: DataStructure {
    
    // 큐에 사용될 기본 배열
    private var queue = [T]()
    
    // DataStructure 프로토콜 준수
    var count: Int { queue.count }
    var isEmpty: Bool { queue.isEmpty }
    
    // `enqueue(_:)`
    // 큐에 값을 넣는 메서드
    mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    // `dequeue() -> T?`
    // 큐에서 값을 꺼내는 메서드
    // 값이 없으면 `nil`을 반환하므로, 반환 형태를 옵셔널로 선언
    mutating func dequeue() -> T? {
        if queue.isEmpty { return nil }
        return queue.removeFirst()
    }
}

// MARK: Improved Queue
// 기본 큐는 dequeue 과정에서 `removeFirst()` 메서드를 호출하는데,
// 이 때 첫 번째 값을 꺼낸 후에, 나머지 값들을 한 칸씩 당겨야 한다.
// 이 연산의 시간복잡도는 O(n)으로, 상당히 비효율적
// 따라서 값을 꺼낸 후, 그 자리를 `nil`로 치환한다.
// 언제까지 `nil`로 둘 수는 없으니, 적당한 시기에 쌓인 `nil`들을 제거해준다.
struct IQueue<T>: DataStructure {
    
    // 개선 큐에 사용될 기본 배열
    // 이 때 배열에 `nil`이 들어갈 수 있으므로, 옵셔널로 선언
    private var queue = [T?]()
    // nil을 체크할 변수
    private var front: Int = 0
    
    // DataStructure 프로토콜 준수
    var count: Int { queue.count }
    var isEmpty: Bool { queue.isEmpty }
    
    // `enqueue(_:)`
    // 큐에 값을 넣는 메서드
    // `nil`을 체크해야 하므로, 값이 들어올 때마다 `front`를 증가시킴
    mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    // `dequeue() -> T?`
    // 큐에서 값을 꺼내는 메서드
    // 값이 없으면 `nil`을 반환하므로, 반환 형태를 옵셔널로 선언
    // 큐에 `nil`이 20개 이상 쌓이면 `nil`을 제거하는 작업을 함
    mutating func dequeue() -> T? {
        // 큐가 비어있거나, 꺼낼 값이 `nil`일 경우 `nil`을 반환
        guard !queue.isEmpty, let element = queue[front] else { return nil }
        
        queue[front] = nil
        front += 1
        
        // 쌓인 `nil`들을 제거하는 작업
        if front >= 20 {
            queue.removeFirst(front)
            front = 0
        }
        
        return element
    }
}
