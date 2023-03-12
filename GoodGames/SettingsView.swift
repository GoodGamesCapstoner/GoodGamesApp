//
//  SettingsView.swift
//  GoodGames
//
//  Created by Matt Goulding on 3/12/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Name:")
                    .font(.subheadline)
                Text("\(userVM.user?.firstName ?? "No user found") \(userVM.user?.lastName ?? "")")
                    .font(.title3)
            }
            VStack(alignment: .leading) {
                Text("Email:")
                    .font(.subheadline)
                Text(userVM.user?.email ?? "No user found")
                    .font(.title3)
                    .lineLimit(1)
            }
            
            //MARK: - Logout/Delete Account Buttons
            HStack {
                if userVM.isUserAuthenticated == .signedIn {
    //                    if vm.user == nil {
                    Button {
                        userVM.logOut()
                    } label: {
                        Text("Log out")
                    }
                    .bold()
                    .buttonStyle(.bordered)
                }
                if userVM.isUserAuthenticated == .signedIn {
                    Button {
                        userVM.showDeletion.toggle()
                    } label: {
                        Text("Delete Account")
                            .foregroundColor(.red)
                            .buttonStyle(.borderless)
                    }
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $userVM.showDeletion) {
                        DeleteView(user: userVM.user!)
                    }
                }
            }.padding(.vertical, 5)
            Spacer()
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
                .environmentObject(UserViewModel())
        }
    }
}
