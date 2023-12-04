//
//  RowSearchView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 03/12/2023.
//

import SwiftUI

struct RowView: View {
    let UserView : CombinedUserModel
    var body: some View {
        HStack(spacing: 20) {
            KingfisherAsyncImage(url: URL(string:UserView.userModel.profilePhoto)!)
            VStack(alignment: .leading) {
                Text(UserView.userModel.name)
                    .font(.title2)
                Text(UserView.userHomeModel.lastMessage)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.vertical, 8)
    }
}



