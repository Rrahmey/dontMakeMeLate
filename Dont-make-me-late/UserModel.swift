//
//  UserModel.swift
//  Dont-make-me-late
//
//  Created by Raquel Rahmey on 4/24/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import Foundation

class User {
    var age: Int
    var weight: Int
    var height: Int
    var gender: Gender
    
    init(age: Int, weight: Int, height: Int, gender: Gender) {
        self.age = age
        self.weight = weight
        self.height = height
        self.gender = gender
    }
}

enum Gender{
    case male, female
}
