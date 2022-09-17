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
        
        //adds nav view to the top
        NavigationView {
            
            //creates vertical scrollview
            ScrollView(showsIndicators: false ) {
                //gridviews for thumbnail
                ModelsByCategoryGrid(showBrowse: $showBrowse)
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

//this creates a horizontal grid for each model category
struct ModelsByCategoryGrid: View {
    @Binding var showBrowse: Bool
    let models = Models()
    
    var body: some View {
        VStack {
            ForEach(ModelCategory.allCases, id: \.self) {
                category in
                if let modelsByCategory = models.get(category: category) {
                    HorizontalGrid(showBrowse: $showBrowse, title: category.label, items:modelsByCategory)
                }
            }
        }
    }
}


struct HorizontalGrid: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    var title: String
    var items: [Model]
    private let gridItemLayout = [GridItem(.fixed(150))]
    
    var body: some View {
        VStack(alignment:.leading) {
            
            Seperator()
            
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 22)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(0..<items.count, id: \.self) {
                        index in
                        let model = items[index]
                        
                        //this is what we are telling each model button to do
                        ItemButton(model: model) {
                            //load entity
                            model.asyncLoadModelEntity()
                            //sets this model as the selectedModel, also toggles placementview to be shown.
                            //placementView gets engaged in contentview with environmental object no longer
                            //being nil
                            self.placementSettings.selectedModel = model
                            print("browse view selected \(model.name)")
                            //closes the browse view menu after selecting the model
                            showBrowse = false
                        }

                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
            }
        }
    }
}

//this is the thumbnail button of each model
struct ItemButton: View {
    let model: Model
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(uiImage: self.model.thumbnail)
                .resizable()
                .frame(height: 150)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color(uiColor: .secondarySystemFill))
                .cornerRadius(8)
        }
    }
}

//this is a seperator between horizontal category scroll sections
struct Seperator: View {
    var body: some View {
        Divider()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}
