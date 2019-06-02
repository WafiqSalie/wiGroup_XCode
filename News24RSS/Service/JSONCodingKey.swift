//
//  JSONCodingKey.swift
//  News24RSS
//
//  Created by Wafiq Salie on 2019/06/02.
//  Copyright © 2019 EndCrypt3d. All rights reserved.
//

import Foundation

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}
