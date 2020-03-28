//
// Created by Utsman on 29/3/20.
// Copyright (c) 2020 utsman. All rights reserved.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}