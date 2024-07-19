//
//  FactContent.swift
//  promova-testtask
//
//  Created by user on 19.07.2024.
//

import Foundation
import RealmSwift

class FactContent: Object {
    @Persisted var fact: String = ""
    @Persisted var image: String = ""
}
