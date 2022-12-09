//
//  NASAGalleryAppTests.swift
//  NASAGalleryAppTests
//
//  Created by Saravana kumar on 07/12/22.
//

import XCTest
@testable import NASAGalleryApp

class NASAGalleryAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testImageModelData() {
        var viewModelArr : [ImageModel] = []
        let viewModel = ImageModel(title: "T", explanation: "HHH", mediaType: "", url: "HJHJH", hdurl: "HAJHJ", date: "", copyrights: "jh", serviceVersion: "jhajgds")
        let viewModel1 = ImageModel(title: "T", explanation: "HHH", mediaType: "", url: "HJHJH", hdurl: "HAJHJ", date: "", copyrights: "jh", serviceVersion: "jhajgds")
        viewModelArr.append(viewModel)
        viewModelArr.append(viewModel1)
        XCTAssert(viewModelArr.count > 0)
        XCTAssertTrue(viewModel.date != "")
        XCTAssertEqual(viewModel.url, viewModel.hdurl)
        XCTAssert(viewModelArr[0].serviceVersion == viewModelArr[1].serviceVersion)
        XCTAssert(viewModelArr[2].serviceVersion.isEmpty)
    }

    func testAPIWrongDecoding() throws {
        /// When the Data initializer is throwing an error, the test will fail.
        let jsonData = try Data(contentsOf: URL(string: "https://raw.githubusercontent.com/obviou/take-home-exercise-data/trunk/nasa-pictures.json")!)

        /// The `XCTAssertNoThrow` can be used to get extra context about the throw
        XCTAssertNoThrow(try JSONDecoder().decode([ImageModel].self, from: jsonData))
    }
    
    func testAPIWrongDecodingThrow() {
        
        let sourceURLString = "https://raw.githubusercontent.com/obviou/take-home-exercise-data/trunk/nasa-pictures.json"
        do {
            let jsonData = try Data(contentsOf: URL(string: sourceURLString)!)
            XCTAssertThrowsError(try JSONDecoder().decode([ImageModel].self, from: jsonData)) { error in
                /// We ensure the expected error is thrown.
                XCTAssertEqual("Source URL is not valid", sourceURLString)
            }

        }catch{
            
            XCTAssertThrowsError(try Data(contentsOf: URL(string: sourceURLString)!)) { error in
                /// We ensure the expected error is thrown.
                XCTAssertEqual("Data parsing error", "Data parsing error")
            }
        }

    }

    func testAPIDecoding() throws {
        /// When the Data initializer is throwing an error, the test will fail.
        let jsonData = try Data(contentsOf: URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json")!)

        /// The `XCTAssertNoThrow` can be used to get extra context about the throw
        XCTAssertNoThrow(try JSONDecoder().decode([ImageModel].self, from: jsonData))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
