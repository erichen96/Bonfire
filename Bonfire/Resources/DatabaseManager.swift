//
//  DatabaseManager.swift
//  Bonfire
//
//  Created by Eric Chen on 5/8/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

//Account Manager
extension DatabaseManager{
    public func validateNewUser(with email: String,
                                completion: @escaping((Bool) -> Void)){
        
        //Replaces @ and . because it does not work with firebase
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    /// Insert user to database
    public func insertUser(with user: BonfireUser, completion: @escaping(Bool) -> Void){
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ], withCompletionBlock: {error, _ in
            guard error == nil else {
                print("Failed to write to database")
                completion(false)
                return
            }
            completion(true)
        })
    }
}



struct BonfireUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    // Firebase cant store ., @, [, or ] so replace with -
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
}
