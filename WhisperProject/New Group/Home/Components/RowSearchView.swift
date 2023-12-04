//
//  RowView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI

struct RowSearchView: View {
    let user : UserModel
    var body: some View {
        HStack(spacing: 20) {
            KingfisherAsyncImage(url: URL(string:user.profilePhoto)!)
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.title2)
                Text(user.phone)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.vertical, 8)
    }
}

