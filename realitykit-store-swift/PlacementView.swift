//
//  PlacementView.swift
//  realitykit-store-swift
//
//  Created by steffan crowley on 9/13/22.
//

import SwiftUI

//this view determines if we place the model or close out and abandon placement
struct PlacementView: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        HStack {
            
            Spacer()
            
            PlacementButton(systemIconName: "xmark.circle.fill") {
                print("cancel placement button pressed")
                //hides placement view by setting it back to nil
                self.placementSettings.selectedModel = nil
            }
            
            Spacer()
            
            PlacementButton(systemIconName: "checkmark.circle.fill") {
                print("confirm placement button pressed")
                //confirms model
                self.placementSettings.confirmedModel = self.placementSettings.selectedModel
                //hides placement view by setting it back to nil
                self.placementSettings.selectedModel = nil
            }
            
            Spacer()
            
        }
        .padding(.bottom, 30)
    }
}

//this just makes the confirm and cancel button so we don't repeat same code twice
struct PlacementButton: View {
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: systemIconName)
                .font(.system(size: 50, weight: .light, design: .default))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 75, height: 75)
    }
}
