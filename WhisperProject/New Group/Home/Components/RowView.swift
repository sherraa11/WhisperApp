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
                HStack{
                    Text(UserView.userModel.name)
                        .font(.title2)
                    Spacer()
                    Text(UserView.userHomeModel.lastMessageTimestamp.formattedTime())
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                }
                Text(UserView.userHomeModel.lastMessageSenderId == FirestoreManager.shared.getCurrentUserID() ?"You: " + UserView.userHomeModel.lastMessage : UserView.userHomeModel.lastMessage )
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.vertical, 8)
    }
}



