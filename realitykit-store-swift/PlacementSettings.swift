//
//  PlacementSettings.swift
//  realitykit-store-swift
//
//  Created by steffan crowley on 9/13/22.
//

import SwiftUI
import RealityKit
import Combine

 

class PlacementSettings: ObservableObject {
    
    //When the user selects a model in BrowseView, this property is set.
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    //When the user taps confirm in PlacementView, the value of selectedModel is assigned to confirmedModel
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            print("Setting confirmedModel to \(model.name)")
        }
    }
    
    
    var sceneObserver: Cancellable?
}
