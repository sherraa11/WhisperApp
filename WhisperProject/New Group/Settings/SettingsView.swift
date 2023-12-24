//
//  SettingsView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 22/12/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Button {
                    
                } label: {
                    Text("About")
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                }.padding()
                Divider().padding(.horizontal, 20)
                Button {
//                    AuthentecationManager.shared.logout { error in
//                        if let error = error {
//                            print(error)
//                        }else{
//                            withAnimation {
//                                UserDefaults.standard.set(false, forKey: "showHome")
//                            }
//                        }
//                    }
                } label: {
                    Text("Log out")
                        .foregroundStyle(.red)
                        .fontWeight(.semibold)
                }.padding()
            }
            Spacer()
        }
    }
}

#Preview {
    SettingsView().presentationDetents([.fraction(0.2)])
}
