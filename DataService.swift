
//  File.swift
//  first-social-media
//
//  Created by anna :)  on 8/10/16.
//  Copyright © 2016 Anna Chiu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

var URL_BASE = "https://first-social-media-project.firebaseio.com"

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = FIRDatabase.database().reference()
    private var _REF_USERS = FIRDatabase.database().referenceFromURL("\(URL_BASE)")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        //Here is gets the uid from a specific user
        //However if there isn't a uid it will create one
        
        REF_USERS.child(uid).setValue(user)
        
    }
    
    

}