//
//  DataStructureProtocol.swift
//  DataStructure
//
//  Created by 김세영 on 2021/09/10.
//

import Foundation

protocol DataStructure {
    var count: Int { get }
    var isEmpty: Bool { get }
    func print()
}
