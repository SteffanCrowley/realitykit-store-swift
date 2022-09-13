//
//  ControlView.swift
//  realitykit-store-swift
//
//  Created by steffan crowley on 9/12/22.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControlsVisible: Bool
    
    var body: some View {
        VStack {
            
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            
            Spacer()
            
            if isControlsVisible {
                ControlButtonBar()
            }
            
        }
    }
}

struct ControlVisibilityToggleButton: View {
    @Binding var isControlsVisible: Bool
    
    var body: some View {
        HStack {
            
            Spacer()
            
            ZStack {
                
                Color.black.opacity(0.25)
                
                ControlButton(systemIconName: isControlsVisible ? "rectangle" : "slider.horizontal.below.rectangle"){
                    print("Control visibility Toggle pressed")
                    isControlsVisible.toggle()
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
            
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
}

struct ControlButtonBar: View {
    var body: some View {
        HStack {
            
            ControlButton(systemIconName: "clock.fill"){
                print("most recently placed button pressed")}
            
            Spacer()
            
            ControlButton(systemIconName: "square.grid.2x2"){
                print("browse button pressed")}

            Spacer()
            
            ControlButton(systemIconName: "slider.horizontal.3"){
                print("Settings button pressed")}
            
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black
            .opacity(0.25))
    }
}

struct ControlButton: View {
    
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            Image(systemName: systemIconName)
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width:50, height: 50)
        
    }
}
