//
// Created by Utsman on 28/3/20.
// Copyright (c) 2020 utsman. All rights reserved.
//

import Foundation
import SwiftUI
import struct Kingfisher.KFImage

struct ItemView: View {
    var url = URL(string: "")

    init(url: Url) {
        self.url = URL(string: url.small)!
    }

    var body: some View {
        KFImage(self.url)
            .resizable()
            .cancelOnDisappear(true)
            .aspectRatio(contentMode: .fit)
    }
}