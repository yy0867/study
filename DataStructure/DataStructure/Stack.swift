//
//  Stacj.swift
//  DataStructure
//
//  Created by 김세영 on 2021/09/10.
//

import Foundation

struct Stack<T>: DataStructure {
    
    // 스택에 사용될 기본 배열
    private var stack = [T]()
    
    // DataStructure 프로토콜 준수
    var count: Int { stack.count }
    var isEmpty: Bool { stack.isEmpty }
    
    // `top`
    // 스택에 가장 최근에 들어간 값을 확인하는 프로퍼티
    // 스택이 비어 있다면 `nil`을 반환하므로, 반환값을 옵셔널로 선언
    var top: T? {
        if stack.isEmpty { return nil }
        return stack.last
    }
    
    // `push(_:)`
    // 스택에 값을 넣는 메서드
    mutating func push(_ element: T) {
        stack.append(element)
    }
    
    // `pop() -> T?`
    // 스택에서 값을 꺼내는 메서드
    // 스택이 비어 있다면 `nil`을 반환하므로, 반환값을 옵셔널로 선언
    mutating func pop() -> T? {
        if stack.isEmpty { return nil }
        return stack.removeLast()
    }
}
