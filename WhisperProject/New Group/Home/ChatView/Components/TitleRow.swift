//
//  TitleRow.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI

struct TitleRow: View {
    var imageUrl : URL
    var name : String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack(spacing: 20) {
            
            Image(systemName: "chevron.left")
                .font(.system(size: 20))
                .onTapGesture {
                    dismiss.callAsFunction()
                }
            
            CacheAsyncImage(url: imageUrl) { phase in
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
                    Image(systemName: "person.circle")
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
                    .font(.title)
                    .lineLimit(1)

                Text("Online")
                    .font(.caption)
                    .foregroundColor(Color("bcolor"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "info.circle")
                .padding(10)
                .background(.white)
                .cornerRadius(50)
        }
        .padding()
    }
}
