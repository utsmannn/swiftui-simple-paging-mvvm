//
// Created by Utsman on 28/3/20.
// Copyright (c) 2020 utsman. All rights reserved.
//

import Foundation

class UnsplashViewModel: ObservableObject {

    @Published var photos = [Unsplash]()
    @Published var isLoading = true

    public func getPhoto(page: Int) {
        let urlUnsplash = URL(string: "https://api.unsplash.com/photos?page=\(page)&per_page=10&client_id=9c72b38fec37970e35dbe5c8d558c2bcb42eb72ca36a038cde056bc9d536dbe9")

        guard let url = urlUnsplash else { return }

        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print("connection success")
            DispatchQueue.main.async(execute: {
                self.isLoading = true
            })
            guard let dataUnsplash = data, error == nil, response != nil else {
                print("connection failed")
                DispatchQueue.main.async(execute: {
                    self.isLoading = false
                })
                return
            }

            do {
                let responses = try JSONDecoder().decode([Unsplash].self, from: dataUnsplash)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                    self.photos.append(contentsOf: responses.self)
                    self.isLoading = false
                })
            } catch {
                print("error get data -> \(error.localizedDescription)")
            }
        }.resume()
    }

    public func clearItems() {
        self.photos.removeAll()
        self.isLoading = false
    }

    public func searchPhotos(query: String, page: Int) {
        let urlUnsplash = URL(string: "https://api.unsplash.com/search/photos?page=\(page)&per_page=10&query=\(query)&client_id=9c72b38fec37970e35dbe5c8d558c2bcb42eb72ca36a038cde056bc9d536dbe9")
        guard let url = urlUnsplash else { return }

        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print("connection success")
            DispatchQueue.main.async(execute: {
                self.isLoading = true
            })

            guard let dataUnsplash = data, error == nil, response != nil else {
                print("connection failed")
                DispatchQueue.main.async(execute: {
                    self.isLoading = false
                })
                return
            }

            do {
                let responses = try JSONDecoder().decode(Search.self, from: dataUnsplash)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                    self.photos.append(contentsOf: responses.results.self)
                    self.isLoading = false
                })
            } catch {
                print("error get data -> \(error.localizedDescription)")
            }
        }.resume()
    }
}