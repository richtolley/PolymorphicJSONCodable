//
//  Codables.swift
//  PolyMorphicJSON
//
//  Created by Richard Tolley on 16/09/2020.
//  Copyright © 2020 Glovo. All rights reserved.
//

import Foundation

struct PayloadVersion1: PayloadBody {
  let name: String
}

struct PayloadVersion2: PayloadBody {
  let number: Int
}

protocol PayloadBody: Decodable {

}

struct Payload: Decodable {
  let version: Int
  let body: PayloadBody

  enum CodingKeys: String, CodingKey {
    case version
    case body
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.version = try values.decode(Int.self, forKey: .version)

    if version == 0 {
      self.body = try values.decode(PayloadVersion1.self, forKey: .body)
    } else if version == 1 {
      self.body = try values.decode(PayloadVersion2.self, forKey: .body)
    } else {
      throw DecodingError.keyNotFound(CodingKeys.body, DecodingError.Context(codingPath: [CodingKeys.body], debugDescription: "unrecognised payload type"))
    }
  }

}
