//
//  UserProfile.swift
//  FirebaseApp
//
//  Created by Athiban on 26.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import Foundation

class UserProfile {
    
    var uid:String
    var username:String
    var photoURL:URL
    
    init(uid:String, username:String,photoURL:URL) {
        self.uid = uid
        self.photoURL = photoURL
        self.username = username
    }
}
