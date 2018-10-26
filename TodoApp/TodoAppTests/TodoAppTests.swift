//
//  TodoAppTests.swift
//  TodoAppTests
//
//  Created by Paul Ancajima on 10/22/18.
//  Copyright © 2018 Paul Ancajima. All rights reserved.
//

import XCTest
@testable import TodoApp

class TodoAppTests: XCTestCase {
    
    
    func test_add_task(){
        let vc = ViewController()
        vc.addTask(name: "hello")
        //edit out line around 123 of ViewController to stop tableView.reloadData before testing
        XCTAssert(vc.tasks[vc.tasks.count-1].name == "hello")
    }
    
    func test_checked_task(){
        let vc = ViewController()
        vc.addTask(name: "hello")
        vc.changeButton(checkBox: false, index: vc.tasks.count-1)
        //edit out line around 132 to stop tableView.reloadData before testing
        XCTAssert(vc.tasks[vc.tasks.count-1].checked == false)
    }
    
    func test_findTask(){
        let vc = ViewController()
        vc.addTask(name: "hello")
        //edit out tableview.reloadDate around 123 and 132 before testing
        XCTAssert(findTask(tasks: vc.tasks, name: "hello") == vc.tasks.count-1)
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
