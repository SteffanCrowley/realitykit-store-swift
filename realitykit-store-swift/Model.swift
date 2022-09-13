//
//  Model.swift
//  realitykit-store-swift
//
//  Created by steffan crowley on 9/13/22.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case main
    case second
    case third
    case fourth
    
    var label: String {
        get {
            switch self {
            case .main:
                return "Main"
            case .second:
                return "Second"
            case .third:
                return "Third"
            case .fourth:
                return "Fourth"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    init(name: String, category:ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    //TODO: Create a method to async load modelEntity
}

struct Models {
    var all: [Model] = []
    
    init() {
        //Main
        let fender = Model(name: "fender_stratocaster", category: .main, scaleCompensation: 0.32/100)
        let plane = Model(name: "toy_biplane", category: .main, scaleCompensation: 0.32/100)
        let robot = Model(name: "toy_robot_vintage", category: .main, scaleCompensation: 0.32/100)
        let wateringCan = Model(name: "wateringcan", category: .main, scaleCompensation: 0.32/100)
        
        self.all += [fender, plane, robot, wateringCan]
    }
    func get(category: ModelCategory) -> [Model] {
        return all.filter({$0.category == category})
    }
}
