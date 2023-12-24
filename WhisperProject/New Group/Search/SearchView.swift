//
//  SearchView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 13/12/2023.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var vm = SearchViewModel()
    var body: some View {
        NavigationStack{
            VStack{ RoundedRectangle(cornerRadius: 10)
                    .frame(width: 335, height: 34)
                    .foregroundStyle(.clear)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.terqwaz , lineWidth:1)
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 10))
                                .padding(.horizontal ,9)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        TextField("Type something ......",text: $vm.searchText)
                            .font(.custom("Poppins", size: 10))
                        
                            .fontWeight(.medium)
                            .padding(.leading , 25)
                    }
                if vm.isSearching() {
                    List(vm.filteredFriends) { friend in
                        NavigationLink {
                            OtherUserProfileView( user: friend)
                        } label: {
                            RowSearchView(user: friend)
                        }
                    }.listStyle(.plain)
                }
                Spacer()
            }
            .navigationTitle("Search")
            .toolbar(.visible)
            .navigationBarTitleDisplayMode(.inline)
         
        }
    }
}

#Preview {
    SearchView()
}
