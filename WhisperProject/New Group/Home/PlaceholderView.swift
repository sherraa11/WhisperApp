//
//  PlaceholderView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 03/12/2023.
//

import SwiftUI
import Shimmer

struct PlaceholderView: View {
    @State var text : String = ""
    var body: some View {
        NavigationStack{
            VStack {
                List(0..<7) { _ in
                    HStack(spacing: 20){
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                            
                            
                        VStack(alignment: .leading) {
                            Text("Long name person ... ")
                                .font(.title2)
                            Text("Last Message")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }.shimmering()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .redacted(reason: .placeholder)
                    .padding(.vertical, 8)
                }.scrollDisabled(true)
            }
            .listStyle(.plain)
                .navigationTitle("Chats")
        }.searchable(text: $text,placement: .navigationBarDrawer(displayMode: .always))
            
    }
}



#Preview {
    PlaceholderView()
}
