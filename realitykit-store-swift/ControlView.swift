//
//  ControlView.swift
//  realitykit-store-swift
//
//  Created by steffan crowley on 9/12/22.
//

import SwiftUI

struct ControlView: View {
    
    @Binding var isControlsVisible: Bool
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        
        VStack {
            //Top right button that decides whether to show bottom menu or not
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            
            Spacer()
            
            if isControlsVisible {
                ControlButtonBar(showBrowse: $showBrowse)
            }
            
        }
    }
}

//this is the toggle bottom menu bar button that decides whether to show bottom menu or not
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


//this view shows the bottom button menu
struct ControlButtonBar: View {
    @Binding var showBrowse: Bool
    
    var body: some View {
        HStack {
            
            //most recently placed button
            ControlButton(systemIconName: "clock.fill"){
                print("most recently placed button pressed")}
            
            Spacer()
            
            //browse button - this button shows the browseview sheet.
            ControlButton(systemIconName: "square.grid.2x2"){
                print("browse button pressed")
                showBrowse.toggle()
            }.sheet(isPresented: $showBrowse, content: {
                BrowseView(showBrowse: $showBrowse)
            })


            Spacer()
            
            //settings button
            ControlButton(systemIconName: "slider.horizontal.3"){
                print("Settings button pressed")}
            
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black
            .opacity(0.25))
    }
}

//this view makes the bottom menu buttons. you simply pass it action and systemIcon and it makes a button.
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
