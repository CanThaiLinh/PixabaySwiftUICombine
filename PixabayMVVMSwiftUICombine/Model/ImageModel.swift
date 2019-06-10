//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftUI

struct ImageModel: Identifiable, Decodable {
    var id: Int
    var largeImageURL: String
    var previewURL: String
}
