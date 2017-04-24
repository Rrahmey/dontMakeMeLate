//
//  UserModel.swift
//  Dont-make-me-late
//
//  Created by Raquel Rahmey on 4/24/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import Foundation

class User {
    var age: Double
    var weight: Double
    var height: Double
    var gender: Gender
    
    init(age: Double, weight: Double, height: Double, gender: Gender) {
        self.age = age
        self.weight = weight
        self.height = height
        self.gender = gender
    }
}

enum Gender{
    case male, female
}
