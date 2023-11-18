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
            
            
            CacheAsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                case .failure(_):
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                @unknown default:
                    fatalError()
                }
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2)
                
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }.padding(.vertical, 8)
    }
}
#Preview {
    RowView(imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/chatapp-9879e.appspot.com/o/ie2WBFTrAgUzPMsTw0MjWyOdJnA2?alt=media&token=b4466f6a-b8c7-474f-86d8-167088086d9c")!, name: "عشري")
}
