//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftUI
import Combine

class ImageListViewModel: BindableObject {

    var images: [ImageModel] {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(())
            }
        }
    }

    private let pixaBayService = PixaBayService()

    init(images: [ImageModel] = []) {
        self.images = images
    }

    func search(withTerm term: String) {

        isActive = true

        pixaBayService.fetch(searchTerm: term) { [weak self] (data, error) in

            self?.isActive = false

            guard error == nil else {
                print(error!)
                return
            }

            guard let data = data else {
                print("no data")
                return
            }

            self?.images = data.hits
        }
    }

    var didChange = PassthroughSubject<Void, Never>()
    var isActive: Bool = false
}