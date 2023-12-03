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
            KingfisherAsyncImage(url: imageUrl)
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
