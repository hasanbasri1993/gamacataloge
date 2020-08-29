//
//  EnvironmentValues+ImageCache.swift
//  gamacataloge
//
//  Created by Hasan Basri on 29/08/20.
//  Copyright © 2020 Hasan Basri. All rights reserved.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
