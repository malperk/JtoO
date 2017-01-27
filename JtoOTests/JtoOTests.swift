//
//  JtoOTests.swift
//  JtoOTests
//
//  Created by Alper KARATAŞ on 25/01/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import XCTest
@testable import JtoO
struct TestStruct1 {
    let stringVal:String
    let intVal:Int 
}
struct TestStruct2 {
    let stringVal:String?
    let intVal:Int?
}

class JtoOTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1() {
        let dict = ["stringVal":"testString","intVal":42] as [String : Any]
        let val:TestStruct1 = try! construct(dict: dict)
        XCTAssertNotNil(val)
        XCTAssertEqual(val.stringVal,"testString")
        XCTAssertEqual(val.intVal,42)
    }
    
    func test2() {
        let dict = ["stringVal":"testString","intVal":42] as [String : Any]
        let val:TestStruct2 = try! construct(dict: dict)
        XCTAssertNotNil(val)
        XCTAssertEqual(val.stringVal,"testString")
        XCTAssertEqual(val.intVal,42)
    }
    
    func test3() {
        let dict = ["stringVal":nil,"intVal":42] as [String : Any?]
        let val:TestStruct2 = try! construct(dict: dict)
        XCTAssertNotNil(val)
        XCTAssertNil(val.stringVal)
        XCTAssertEqual(val.intVal,42)
    }
    
    func test4() {
        XCTAssertThrowsError(try test4Error()) { error in
            XCTAssertEqual(error as? JtoOError, JtoOError.typeMismatch(key: "intVal"))
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

func test4Error() throws {
    let dict = ["stringVal":"testString","intVal":"testString"] as [String : Any?]
    do {
        let _:TestStruct1 = try construct(dict: dict)
    } catch let error as JtoOError {
        throw error
    }
    catch{
        XCTFail()
    }
}
