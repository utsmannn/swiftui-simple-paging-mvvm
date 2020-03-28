//
//  ContentView.swift
//  unsplash-learn
//
//  Created by Utsman on 28/3/20.
//  Copyright © 2020 utsman. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ContentView: View {

    @ObservedObject var viewModel = UnsplashViewModel()
    @State var page: Int = 1
    @State var textSearch = ""

    init() {
        viewModel = UnsplashViewModel()
        viewModel.getPhoto(page: self.page)
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Photo", text: $textSearch, onEditingChanged: { _ -> Void in
                }, onCommit: {
                    self.page = 1
                    self.viewModel.clearItems()
                    self.getPhotos()
                })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .listRowInsets(EdgeInsets())
                List {
                    ForEach(viewModel.photos.indices, id: \.self) { index in
                        ItemView(url: self.viewModel.photos[index].urls)
                                .onAppear(perform: {
                                    let count = self.viewModel.photos.count
                                    print("loading is -> \(self.viewModel.isLoading)")
                                    if index == count - 1 {
                                        self.page += 1
                                        print("this end of page -> \(index) page is -> \(self.page)")
                                        self.getPhotos()
                                    }
                                })
                    }
                }
                if self.viewModel.isLoading {
                    ActivityIndicator(style: .medium)
                }
            }.navigationBarTitle(Text("Unsplash"), displayMode: .automatic)

        }
    }

    private func getPhotos() {
        if self.textSearch.count < 1 {
            self.viewModel.getPhoto(page: self.page)
        } else {
            self.viewModel.searchPhotos(query: self.textSearch, page: self.page)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
