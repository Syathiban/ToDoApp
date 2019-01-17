//
//  IndexofRow¨.swift
//  FirebaseApp
//
//  Created by Athiban on 28.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import Foundation

class IndexofRow {
    
    var index = 0
    static let shared = IndexofRow()
    private init() {
        
    }
    
    func addIndex(myIndex: Int) {
        index = myIndex
    }
    
    func getIndex() -> Int {
        return index
    }
    
    
    
}
