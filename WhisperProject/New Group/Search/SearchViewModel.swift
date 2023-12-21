//
//  SearchViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 20/12/2023.
//

import Foundation
class SearchViewModel : ObservableObject {
    @Published var allUserList = [UserModel]()
    @Published var searchText : String = ""
    
    
    init(){
        getAllUsers()
    }
    
    
    //    check if user searching
        func isSearching()  -> Bool {
            if searchText.isEmpty {
                return false
            }else {
                return true
            }
        }
    
    
    //    filter data based on user search (phone , name)
        var filteredFriends: [UserModel] {
            guard !searchText.isEmpty else { return allUserList }
            return allUserList.filter { friend in
                return friend.phone.localizedCaseInsensitiveContains(searchText) ||
                       friend.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    
    // i wanted to perform a better search experience but it should make the search from firebase
        func getAllUsers() {
            FirestoreManager.shared.getData { Allusers in
                if Allusers != nil {
                    DispatchQueue.main.async {
                        self.allUserList = Allusers!
                    }
                }
            }
        }
}
