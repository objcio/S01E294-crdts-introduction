//
//  BonjourSampleTests.swift
//  BonjourSampleTests
//
//  Created by Chris Eidhof on 15.02.22.
//

import XCTest
@testable import BonjourSample

fileprivate let testCycles = 1000

extension Int {
    static func random() -> Int {
        Int.random(in: Int.min..<Int.max)
    }
}

class BonjourSampleTests: XCTestCase {
    func testMax() {
        for _ in 0..<testCycles {
            let a = Max(value: Int.random())
            let b = Max(value: Int.random())
            let c = Max(value: Int.random())
            XCTAssertEqual(a.merged(b), b.merged(a))
            XCTAssertEqual(a.merged(a), a)
            XCTAssertEqual((a.merged(b)).merged(c), a.merged(b.merged(c)))
        }
    }
}
