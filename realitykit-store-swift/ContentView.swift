//
//  ContentView.swift
//  realitykit-store-swift
//
//  Created by steffan crowley on 9/12/22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @State private var isControlsVisible: Bool = true
    @State private var showBrowse: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            //calls the ARVIEW
             ARViewContainer()
            
            //if placementSettings view gets toggled, we decide here to show the PlacementView, else its control view
            if self.placementSettings.selectedModel == nil {
                ControlView(isControlsVisible: $isControlsVisible, showBrowse: $showBrowse)
            } else {
                PlacementView()
            }

        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    func makeUIView(context: Context) -> CustomARView {
        
        //setting current ARView to the custom one we made
        let arView = CustomARView(frame: .zero)
        
        //subscribe to sceneEvents.Update
        self.placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { (event) in
            
            self.updateScene(for: arView)
        })
        
        return arView
        
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    
    private func updateScene(for arView: CustomARView) {
        
        //Only display focusEntity when the user has selected a model for placement
        arView.focusEntity?.isEnabled = self.placementSettings.selectedModel != nil
        
        //add model to scene if confirmed for placement
        if let confirmedModel = self.placementSettings.confirmedModel, let modelEntity = confirmedModel.modelEntity {
            
            self.place(modelEntity, in: arView)
            
            self.placementSettings.confirmedModel = nil
            
        }
        
    }
    
    private func place(_ modelEntity: ModelEntity, in arView: ARView) {
       
        // 1) clone model entity.  this creates an identical copy of modelEntity and references the same model.  This also allows us to have multiple models of the same asset in our scene.
        let clonedEntity = modelEntity.clone(recursive: true)
        
        // 2) Enable translation and rotation gestures
        clonedEntity.generateCollisionShapes(recursive: true)
        arView.installGestures(for: clonedEntity)
        
        // 3) Create an anchorEntity and add clonedEntity to the anchorEntity
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        
        // 4) Add the anchorEntity to the arView.scene
        arView.scene.addAnchor(anchorEntity)
        
        print("added model entity to scene")
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .environmentObject(PlacementSettings())
    }
}
#endif
