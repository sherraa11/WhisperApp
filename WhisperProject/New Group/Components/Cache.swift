//
//  Cache.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI
import Kingfisher

struct KingfisherAsyncImage: View {
    let url: URL
    
    var body: some View {
        KFImage(url)
            .placeholder {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .foregroundStyle(.black.opacity(0.7))
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 35, height: 35)
            .clipShape(Circle())
        
        
    }
}
