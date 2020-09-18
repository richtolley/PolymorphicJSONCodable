//
//  PolyMorphicJSONTests.swift
//  PolyMorphicJSONTests
//
//  Created by Richard Tolley on 18/09/2020.
//  Copyright © 2020 Glovo. All rights reserved.
//

import XCTest

@testable import PolyMorphicJSON

class PolyMorphicJSONTests: XCTestCase {

  override func setUpWithError() throws {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  func testType1Deserialization() {
    guard let dataURL = Bundle(for: PolyMorphicJSONTests.self).url(forResource: "test1", withExtension: "json") else {
      XCTFail("data url should not be nil")
      return
    }

    do {
      let data = try Data(contentsOf: dataURL)
      let payload = try JSONDecoder().decode(Payload.self, from: data)
      XCTAssertNotNil((payload.body as? PayloadVersion1), "incorrect type of payload")
    } catch let error {
      XCTFail("failed to deserialize json because: \(error.localizedDescription)")
    }
  }

  func testType2Deserialization() {
    guard let dataURL = Bundle(for: PolyMorphicJSONTests.self).url(forResource: "test2", withExtension: "json") else {
      XCTFail("data url should not be nil")
      return
    }

    do {
      let data = try Data(contentsOf: dataURL)
      let payload = try JSONDecoder().decode(Payload.self, from: data)
      XCTAssertNotNil((payload.body as? PayloadVersion2), "incorrect type of payload")
    } catch let error {
      XCTFail("failed to deserialize json because: \(error.localizedDescription)")
    }
  }

  func testIncorrectTypeDeserialization() {
    guard let dataURL = Bundle(for: PolyMorphicJSONTests.self).url(forResource: "test3", withExtension: "json") else {
      XCTFail("data url should not be nil")
      return
    }

    do {
      let data = try Data(contentsOf: dataURL)
      _ = try JSONDecoder().decode(Payload.self, from: data)
      XCTFail("should not succeed")
    } catch let error {

      XCTAssertEqual(error.localizedDescription,"The data couldn’t be read because it is missing.")
    }
  }

  func testUnknownVersionDeserialization() {
    guard let dataURL = Bundle(for: PolyMorphicJSONTests.self).url(forResource: "test4", withExtension: "json") else {
      XCTFail("data url should not be nil")
      return
    }

    do {
      let data = try Data(contentsOf: dataURL)
      _ = try JSONDecoder().decode(Payload.self, from: data)
      XCTFail("should not succeed")
    } catch let error {

      XCTAssertEqual(error.localizedDescription,"The data couldn’t be read because it is missing.")
    }
  }
}
