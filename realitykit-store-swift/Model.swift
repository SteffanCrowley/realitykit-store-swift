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
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category:ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: {
                loadCompletion in
                switch loadCompletion {
                case .failure(let error): print("unable to load model entity for \(filename) Error \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: {
                modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name)and \(filename) has been loaded")
            })
    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        //Main
        let fender = Model(name: "fender_stratocaster", category: .main, scaleCompensation: 25/100)
        let plane = Model(name: "toy_biplane", category: .main, scaleCompensation: 25/100)
        let robot = Model(name: "toy_robot_vintage", category: .main, scaleCompensation: 25/100)
        let wateringCan = Model(name: "wateringcan", category: .main, scaleCompensation: 25/100)
        
        self.all += [fender, plane, robot, wateringCan]
    }
    func get(category: ModelCategory) -> [Model] {
        return all.filter({$0.category == category})
    }
}
