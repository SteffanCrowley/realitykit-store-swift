//
//  BrowseView.swift
//  realitykit-store-swift
//
//  Created by steffan crowley on 9/13/22.
//

import SwiftUI

struct BrowseView: View {
    @Binding var showBrowse: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false ) {
                //gridviews for thumbnail
            }
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button("Done") {
                    showBrowse.toggle()
                }
            }
        }
    }
}
