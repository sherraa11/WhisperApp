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
                    .frame(width: 335, height: 40)
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
                            .font(.custom("Poppins", size: 14))
                            .frame(height: 40)
                            .fontWeight(.medium)
                            .padding(.leading , 25)
                    }
                if vm.isSearching() {
                    if !vm.filteredFriends.isEmpty{
                        List(vm.filteredFriends) { friend in
                            NavigationLink {
                                OtherUserProfileView( user: friend)
                            } label: {
                                RowSearchView(user: friend)
                            }
                        }.listStyle(.plain)
                    } else {
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 40))
                            .foregroundStyle(.gray)
                        
                        Text("No Results")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.top, 8)
                        
                        Text("Check the spelling or try a new search.")
                            .font(.custom("Poppins", size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                        
                        
                        Spacer()
                       
                    }
                }else {
                    Spacer()
                    
                    Image(.people)
                        .resizable()
                        .frame(width: 150, height: 150)
                  
                    
                    Text("Start your search and connect with someone new.")
                        .font(.system(size: 20))
//                        .fontWeight(.bold)
                        .padding(.top, 16)
                        .multilineTextAlignment(.center)
                    

                    Spacer()
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
