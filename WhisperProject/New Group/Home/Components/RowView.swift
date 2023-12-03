//
//  RowView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI

struct RowView: View {
    let imageURL : URL
    let name : String
    var body: some View {
        HStack(spacing: 20) {
            KingfisherAsyncImage(url: imageURL)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2)
                Text("Last Message")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.vertical, 8)
    }
}

