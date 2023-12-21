//
//  EditProfileView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 11/12/2023.
//

import SwiftUI
import PhotosUI
import Kingfisher


struct EditProfileView: View {
    @ObservedObject var vm = EditProfileViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
       NavigationStack{
            VStack{
                HStack{
                    PhotosPicker(selection: $vm.imageSelection, matching: .images) {
                        if let selectedImage = vm.selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 76, height: 76)
                                .clipShape(Circle())
                        } else {
                            KFImage(vm.photoURL)
                                .placeholder { loading in
                                    Circle()
                                        .frame(width: 67, height: 67)
                                        .foregroundStyle(.white)
                                        .overlay {
                                            Circle()
                                                .stroke(.terqwaz, lineWidth: 1)
                                            ProgressView()
                                        }
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 76, height: 76)
                                .clipShape(Circle())
                        }
                    }
                    VStack(alignment : .leading){
                        if let currentData = vm.currentUserData {
                            Text(currentData.name)
                                .font(.custom("Poppins", size: 18))
                                .fontWeight(.semibold)
                            Text(currentData.username)
                                .font(.custom("Poppins", size: 14))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    Spacer()
                }.padding(.top, 25)
                    .padding(.leading , 29)
                VStack{
                    HStack {
                        Text("Full name ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black.opacity(0.7))
                        Spacer()}.padding(.top ,20)
                    TextField("", text: $vm.updatedFullName)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.medium)
                        .padding()
                        .background(.textFieldbackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .autocorrectionDisabled()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(vm.showNameError ? Color.red : Color.clear, lineWidth: 1)
                        )
                    HStack {
                        Text("Username ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.7))
                        Spacer()}.padding(.top ,12)
                    TextField("", text: $vm.updatedUserName)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.medium)
                        .padding()
                        .background(.textFieldbackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .autocorrectionDisabled()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(vm.showUsernameError ? Color.red : Color.clear, lineWidth: 1)
                        )
                    HStack {
                        Text("About ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.7))
                        Spacer()}.padding(.top ,12)
                    TextField("", text: $vm.updatedStatus)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.medium)
                        .padding()
                        .background(.textFieldbackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .autocorrectionDisabled()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(vm.showStatusError ? Color.red : Color.clear, lineWidth: 1)
                        )
                    HStack {
                        Text("Phone Number ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.7))
                        Spacer()}.padding(.top ,12)
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.textFieldbackground)
                            .frame(width: 144, height: 49)
                            .overlay{
                                Text(String(FirestoreManager.shared.getCurrentUserPhoneNumber().dropFirst(2)))
                                    
                                    .font(.custom("Poppins", size: 14))
                                    .fontWeight(.medium)
                            }
                        Spacer()
                    }
                 
                }.padding(.horizontal , 29)
                Spacer()
                
            }.navigationTitle("My Profile")
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                   ToolbarItem(placement: .topBarLeading) {
                       Image(systemName:"chevron.down")
                           .foregroundStyle(.black)
                           .font(.system(size: 22))
                           .fontWeight(.semibold)
                           .onTapGesture {
                               withAnimation{
                                   self.dismiss()
                               }
                           }
                   }
                   ToolbarItem(placement: .bottomBar) {
                       Button(action: {
                           vm.checkUser { value in
                               if value && vm.isLoading  {
                                   dismiss()
                               }
                           }
                       }, label: {
                           if vm.isLoading {
                               ProgressView()
                                   .fontWeight(.semibold)
                                   .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                                   .background(.terqwaz)
                                   .clipShape(RoundedRectangle(cornerRadius: 10))
                               
                                   .padding(.bottom, 40)
                                   .tint(.white)
                                   .disabled(true)
                           }else{
                               Text("Update")
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
               .toolbarBackground(.automatic, for: .navigationBar)
            
        }
    }
}
#Preview {
    EditProfileView()
}
