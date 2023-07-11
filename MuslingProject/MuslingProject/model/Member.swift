//
//  Member.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/04.
//

import UIKit

class Member {
    static var shared = Member()
    var user_id: String!
    var pwd: String!
    var name: String!
    var age: String!
    var img: UIImage!
    var profileId: String!
}
