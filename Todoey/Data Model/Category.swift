//
//  Category.swift
//  Todoey
//
//  Created by Alice Fluffy on 2/2/19.
//  Copyright © 2019 Alice Fluffy. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var color: String?
    let items = List<Item>()
    
}
