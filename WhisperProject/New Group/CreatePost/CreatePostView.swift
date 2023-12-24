//
//  CreatePostView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 20/12/2023.
//
import PhotosUI
import SwiftUI

class CreatePostViewModel : ObservableObject {
    @Published var isLoading : Bool = false
    @Published var caption : String = ""
    @Published private(set) var selectedImage : UIImage? = nil
    @Published var imageSelection : PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    private func setImage(from selection :PhotosPickerItem? ) {
        guard let selection else {return}
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self){
                if let uiImage = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.selectedImage = uiImage
                    }
                    return
                }
            }
        }
    }
    
    
    func createPost() {
        if !caption.isEmpty || selectedImage != nil {
            let id = UUID().uuidString
            isLoading = true
            
            if let selectedImage = selectedImage {
                StorageManager.shared.uploadPost(selectedImage: selectedImage) { result in
                    switch result {
                    case .success(let imageUrl):
                        FirestoreManager.shared.getCurrentUserData { userModel in
                            if let currentUser = userModel {
                                FirestoreManager.shared.createPost(caption: self.caption, user: currentUser, id: id, postPhoto: imageUrl) { success in
                                    self.isLoading = false
                                    if success {
                                        self.selectedImage = nil
                                        self.caption = ""
                                            UserDefaults.standard.set(1, forKey: "counter")
                                      
                                        // Handle success in creating the post
                                    } else {
                                        // Handle failure in creating the post
                                    }
                                }
                            } else {
                                self.isLoading = false
                                // Handle error - unable to get user data
                            }
                        }
                    case .failure(let error):
                        self.isLoading = false
                        // Handle error in image upload
                        print("Image upload error: \(error.localizedDescription)")
                    }
                }
            } else {
                FirestoreManager.shared.getCurrentUserData { userModel in
                    if let currentUser = userModel {
                        FirestoreManager.shared.createPost(caption: self.caption, user: currentUser, id: id, postPhoto: "") { success in
                            self.isLoading = false
                            if success {
                                self.caption = ""
                                UserDefaults.standard.set(1, forKey: "counter")
                                
                                // Handle success in creating the post
                            } else {
                                // Handle failure in creating the post
                            }
                        }
                    } else {
                        self.isLoading = false
                        // Handle error - unable to get user data
                    }
                }
            }
        } else {
            isLoading = false
            // Handle error - caption is empty and selectedImage is nil
        }
    }



    
    
    
}

struct CreatePostView: View {
    @ObservedObject var vm = CreatePostViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Select Image")
                        .font(.custom("Poppins", size: 16))
                        .fontWeight(.medium)
                    Spacer()
                }.padding(.horizontal,27).padding(.top, 27)
                
                PhotosPicker(selection: $vm.imageSelection, matching: .images ) {
                    
                    if vm.selectedImage == nil {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width - 54, height: UIScreen.main.bounds.height / 3)
                            .foregroundStyle(Color.textFieldbackground)
                            .overlay{
                                Image(.imageholder)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .opacity(0.3)
                            }
                        
                    }else {
                        Image(uiImage: vm.selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 54, height: UIScreen.main.bounds.height / 3)
//                            .background(.textFieldbackground)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                }.tint(.blue)
                HStack{
                    Text("Add caption")
                        .font(.custom("Poppins", size: 16))
                        .fontWeight(.medium)
                    Spacer()
                }.padding(.horizontal,27).padding(.top, 27)
                TextField("", text: $vm.caption)
                    .font(.custom("Poppins", size: 14))
                    .autocorrectionDisabled()
                    .fontWeight(.medium)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 54 , height: 60)
                    .background(.textFieldbackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }.navigationTitle("Post")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(.visible)
                .toolbar{
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            if !vm.isLoading{
                                vm.createPost()
                            }
                        }, label: {
                            if vm.isLoading {
                                ProgressView()
                                    .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                                    .background(.terqwaz)
                                    .tint(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.bottom, 40)
                                    .disabled(true)
                            }else{
                                Text("Upload")
                                    .font(.custom("Poppins", size: 18))
                                    .fontWeight(.semibold)
                                    .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                                    .background(.terqwaz)
                                    .foregroundStyle(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.bottom, 40)
                            }
                        })
                    }
                }
        }
    }
}

#Preview {
    
        CreatePostView()
    }

