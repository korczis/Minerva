//
//  ImageHelper.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/30/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import Combine
import CoreImage
import Foundation
import SwiftUI

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get {
            cache.object(forKey: key as NSURL)
        }
        
        set {
            newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL)
        }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    static private var cache: ImageCache?

    deinit {
        cancellable?.cancel()
    }
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        ImageLoader.cache = cache
    }
    
    func load() {
        if let image = ImageLoader.cache?[url] {
            self.image = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] in self?.cache($0) })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
    
    private func cache(_ image: UIImage?) {
        image.map { ImageLoader.cache?[url] = $0 }
    }
}

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    
    init(url: URL, placeholder: Placeholder? = nil, cache: ImageCache? = nil) {
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = placeholder
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .border(Color.black, width: 2)
            } else {
                placeholder
            }
        }
    }
}
