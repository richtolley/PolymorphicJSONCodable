//
//  PayloadBody.swift
//  PolyMorphicJSON
//
//  Created by Richard Tolley on 18/09/2020.
//  Copyright © 2020 Glovo. All rights reserved.
//

import Foundation

struct PayloadBodyVersion1: PayloadBody {
  let name: String
}

struct PayloadBodyVersion2: PayloadBody {
  let number: Int
}

protocol PayloadBody: Decodable {

}
