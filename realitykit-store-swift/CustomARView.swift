//
//  CustomARView.swift
//  realitykit-store-swift
//
//  Created by steffan crowley on 9/13/22.
//

import RealityKit
import ARKit
import FocusEntity


//Creates an instance of ARView
class CustomARView: ARView {
    
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
    }
    
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [ .horizontal, .vertical ]
        session.run(config)
    }
}


