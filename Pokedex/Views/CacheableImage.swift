//
//  CacheableImage.swift
//  Pokedex
//
//  Created by Armando Meza on 2/14/23.
//

import SwiftUI

struct CacheableImage: View {
    var url = ""
    
    var body: some View {
        AsyncImage(url: URL(string: url))
            .frame(width: 75, height: 75)
    }
}

struct CacheableImage_Previews: PreviewProvider {
    static var previews: some View {
        CacheableImage()
    }
}
