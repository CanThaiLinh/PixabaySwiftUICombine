//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwURL
import SwiftUI
import Combine
import Foundation

struct ImageListView : View {

    // MARK: Properties

    @ObjectBinding var viewModel = ImageListViewModel(images: [])
    @State private var searchTerm: String = ""

    // MARK: APIs

    var body: some View {
        ActivityIndicatorView(isShowing: $viewModel.isActive) {
            NavigationView {
                Section {
                    HStack {
                        TextField(self.$searchTerm, placeholder: Text("search term")) {
                            self.viewModel.search(withTerm: self.searchTerm)
                        }
                        .textFieldStyle(.roundedBorder)

                        Button(action: {
                            self.viewModel.search(withTerm: self.searchTerm)
                        }) {
                            Text("Search")
                        }
                    }
                    .padding(EdgeInsets(top: 8.0, leading: 16.0, bottom: 8.0, trailing: 16.0))
                }

                Section {
                    List(self.viewModel.images) { image in
                        ImageCell(image: image)
                    }
                }
                .navigationBarTitle(Text("Images"))
                .listStyle(.grouped)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        let viewModel = ImageListViewModel(images: testData)
        var view = ImageListView()
        view.viewModel = viewModel
        return view
    }
}
#endif

struct ImageCell: View {
    var image: ImageModel
    var body: some View {
        NavigationButton(destination: ImageDetailView(image: image)) {
            HStack {
                RemoteImageView
                    .init(url: URL(string: image.previewURL)!, placeholderImage: Image.init(systemName: "icloud.and.arrow.down"))
                    .frame(width: 30, height: 30, alignment: Alignment.center)
                    .clipShape(Ellipse().size(width: 30, height: 30))
                    .scaledToFit()
                Text(image.previewURL)
            }
        }
    }
}
