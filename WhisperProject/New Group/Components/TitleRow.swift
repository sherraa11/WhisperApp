//
//  TitleRow.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI

struct TitleRow: View {
    @State var user : UserModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack(spacing: 20) {
            
            Image(systemName: "chevron.down")
                .font(.system(size: 20))
                .onTapGesture {
                    dismiss.callAsFunction()
                }
            KingfisherAsyncImage(url: URL(string: user.profilePhoto)!)
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.custom("Poppins", size: 18))
                    .fontWeight(.semibold)
                    .lineLimit(1)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            }
        .padding(.horizontal)
        .padding(.top)
    }
}
#Preview {
    TitleRow(user: UserModel(id: " ", name: "heu", phone: "ff", profilePhoto: " ", status: "ff", username: "@djf"))
}
