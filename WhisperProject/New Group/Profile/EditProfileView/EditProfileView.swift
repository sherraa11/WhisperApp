//
//  EditProfileView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 11/12/2023.
//

import SwiftUI

struct EditProfileView: View {
    @State var updatedFullName : String = "Ashri"
    @State var updatedUserName : String = "@ashari11"
    @State var updatedStatus : String = "A7aa"
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
       
            VStack{
                HStack{
                    
                    Spacer()
                    Text("My Profile")
                        .font(.custom("Poppins", size: 18))
                        .fontWeight(.semibold)
                    
                    Spacer()
                }.overlay(content: {
                    HStack{
                        Image(systemName:"chevron.left")
                            .foregroundStyle(.black)
                            .font(.system(size: 25))
                            .fontWeight(.light)
                            .onTapGesture {
                                withAnimation{
                                    self.dismiss()
                                }
                            }
                        Spacer()
                    }
                })
                .padding(.horizontal)
                HStack{
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 67 , height: 67)
                    VStack(alignment : .leading){
                        Text("Ashri el mogrem")
                            .font(.custom("Poppins", size: 18))
                            .fontWeight(.semibold)
                        Text("@ashrii11")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }.padding(.top , 40)
                    .padding(.leading , 29)
                VStack{
                    HStack {
                        Text("Full name ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black.opacity(0.7))
                        Spacer()}.padding(.top ,20)
                    TextField("", text: $updatedFullName)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.medium)
                        .padding()
                        .background(.textFieldbackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    
                    HStack {
                        Text("Username ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.7))
                        Spacer()}.padding(.top ,12)
                    TextField("", text: $updatedUserName)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.medium)
                        .padding()
                        .background(.textFieldbackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    
                    HStack {
                        Text("About ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.7))
                        Spacer()}.padding(.top ,12)
                    TextField("", text: $updatedStatus)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.medium)
                        .padding()
                        .background(.textFieldbackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
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
                                Text("01092772040")
                                    .font(.custom("Poppins", size: 14))
                                    .fontWeight(.medium)
                            }
                        Spacer()
                    }
                    
                }.padding(.horizontal , 29)
                
               Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Update")
                        .font(.custom("Poppins", size: 18))
                        .fontWeight(.semibold)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                        .background(.terqwaz)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top , 24)
                        .padding(.bottom, 40)
                })
                
            }.toolbar(.hidden)
      
    }
}
#Preview {
    EditProfileView()
}
