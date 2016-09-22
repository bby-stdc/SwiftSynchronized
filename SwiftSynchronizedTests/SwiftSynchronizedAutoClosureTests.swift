//
//  SwiftSynchronizedAutoClosureTests.swift
//  SwiftSynchronized
//
//  Created by Jed Lewison on 2/20/16.
//  Copyright © 2016 Magic App Factory. All rights reserved.
//

import XCTest
import SwiftSynchronized

class SwiftSynchronizedAutoClosureTests: XCTestCase {

    var counter = 0
    let blockOpCount = 10000
    let delay: useconds_t = 1
    override func setUp() {
        super.setUp()
        counter = 0
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Allow block operations to simultaneously mutate a property without synchronizing access.
    // The block operation will increment a counter and attempt to decrement it but only if
    // it hasn't been incremented by another operation (when the counter isn't one)

    func incrementCounter() {
        counter += 1
    }

    func decrementCounterIfPossible() {
        if counter == 1 {
            counter -= 1
        } else {
            // Another operation has incremented the counter before we got a chance to decrement it
        }
    }

    func performOperation() {
        incrementCounter()
        usleep(delay)
        decrementCounterIfPossible()
    }


    // Add synchronized directive to protect block of code.
    // Synchronized should give the operation a chance to decrement
    // the count before another operation increments it.

    func testWithSwiftSynchronizedAutoclosureExample() {

        var blockOps = [BlockOperation]()

        for _ in 0...blockOpCount {
            let blockOperation = BlockOperation() {
                synchronized(self, action: self.performOperation())
            }
            blockOps.append(blockOperation)
        }

        let operationQ = OperationQueue()

        operationQ.addOperations(blockOps, waitUntilFinished: true)

        print(counter)

        XCTAssert(counter == 0, "Max count is \(counter)")
    }


    func testWithSwiftLockExample() {

        var blockOps = [BlockOperation]()
        let lock = NSLock()

        for _ in 0...blockOpCount {
            let blockOperation = BlockOperation {
                lock.performAndWait { _ in
                    self.performOperation()
                }
            }
            blockOps.append(blockOperation)
        }

        let operationQ = OperationQueue()

        operationQ.addOperations(blockOps, waitUntilFinished: true)

        print(counter)

        XCTAssert(counter == 0, "Max count is \(counter)")
    }

    func testWithSwiftRecursiveLockExample() {

        var blockOps = [BlockOperation]()
        let lock = NSRecursiveLock()

        for _ in 0...blockOpCount {
            let blockOperation = BlockOperation {
                lock.performAndWait { _ in
                    self.performOperation()
                }
            }
            blockOps.append(blockOperation)
        }

        let operationQ = OperationQueue()

        operationQ.addOperations(blockOps, waitUntilFinished: true)

        print(counter)

        XCTAssert(counter == 0, "Max count is \(counter)")
    }


    func testWithSwiftLockAutoclosureExample() {

        var blockOps = [BlockOperation]()
        let lock = NSLock()

        for _ in 0...blockOpCount {
            let blockOperation = BlockOperation {
                lock.performAndWait( self.performOperation())
            }
            blockOps.append(blockOperation)
        }

        let operationQ = OperationQueue()

        operationQ.addOperations(blockOps, waitUntilFinished: true)

        print(counter)

        XCTAssert(counter == 0, "Max count is \(counter)")
    }

    func testWithSwiftRecursiveLockAutoclosureExample() {

        var blockOps = [BlockOperation]()
        let lock = NSRecursiveLock()

        for _ in 0...blockOpCount {
            let blockOperation = BlockOperation() {
                lock.performAndWait(self.performOperation())
            }
            blockOps.append(blockOperation)
        }

        let operationQ = OperationQueue()

        operationQ.addOperations(blockOps, waitUntilFinished: true)

        print(counter)

        XCTAssert(counter == 0, "Max count is \(counter)")
    }
    
}
