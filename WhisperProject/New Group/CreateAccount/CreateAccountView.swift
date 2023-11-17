//
//  CreateAccountView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//

import SwiftUI
import PhotosUI



struct CreateAccountView: View {
    @ObservedObject var vm = CreateAccountViewModel()

    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading , spacing: 15){
                HStack { Spacer()
                    Text("Create Account")
                        .foregroundStyle(Color("dark1"))
                        .font(.title)
                    Spacer()
                }
                .padding(.bottom,20)
                HStack{
                    Spacer()
                    
                    PhotosPicker(selection: $vm.imageSelection, matching: .images ) {
                        
                        if vm.selectedImage == nil {
                            Image(systemName: "person.crop.circle.badge.plus")
                                .resizable()
                                .frame(width: 100 , height: 80)
                                .foregroundStyle(Color("middleColor"))
                        }else {
                            Image(uiImage: vm.selectedImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100 , height: 100)
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                }
                
                
                Text("Please enter your name")
                    .font(.body)
                    .foregroundStyle(Color.gray)
                    .padding(.top , 12)
                
                
                TextField("name", text: $vm.name)
                    .padding()
                    .background(Color("bcolor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text("About you .. ")
                    .font(.body)
                    .foregroundStyle(Color.gray)
                    .padding(.top , 12)
                
                
                TextField("status", text:$vm.status)
                    .padding()
                    .background(Color("bcolor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                Button(action: {
                    vm.CreataAndUpload()
                }, label: {
                    Text("Create")
                        .font(.custom("Proxima Nova", size: 18))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity )
                        .frame(height: 55)
                        .background(Color("middleColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                }).padding(.top,25)
            }.padding()
                .fullScreenCover(isPresented: $vm.showHome, content: { HomeView() })
        }
    }
}
#Preview {
    CreateAccountView()
}
