//
//  DTCodeChallengeTests.swift
//  DTCodeChallengeTests
//
//  Created by Dhruvin  on 31/08/22.
//

import XCTest
@testable import DTCodeChallenge
import Combine

class DTCodeChallengeTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func test_dataResult_shouldBeEmpty_whenLoadFirstTime() throws {
        let vm = DataViewModel()
        
        XCTAssertTrue(vm.dataResult.isEmpty)
        XCTAssertEqual(vm.dataResult.count, 0)
    }
    
    func test_dataResult_shouldNotBeEmpty_afterAPICall() throws {
        //Given
        let vm = DataViewModel()
        
        //when
        let expectation = XCTestExpectation(description: "Should return items after few seconds")
        
        vm.$dataResult
            .dropFirst()
            .sink { items in
            expectation.fulfill()
            }.store(in: &cancellables)
        
        vm.getResultData()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataResult.count, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
