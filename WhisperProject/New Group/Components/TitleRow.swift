//
//  TitleRow.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI

struct TitleRow: View {
    @State var user : UserModel
    @State var arrow : String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack(spacing: 20) {
            
            Image(systemName: "chevron."+arrow)
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

