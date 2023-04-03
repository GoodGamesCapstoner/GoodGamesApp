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
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        NavigationView {
            List {
                // MARK: - Account Information
                Section(header: Text("Account Information")) {
                    Text("Username: \(userVM.user?.username ?? "No username found")")
                    Text("Name: \(userVM.user?.firstName ?? "No name found") \(userVM.user?.lastName ?? "")")
                    Text("Email: \(userVM.user?.email ?? "No email found")")
                }
                
                //MARK: - Logout/Delete Account Buttons
                Section(header: Text("Actions")) {
                    if userVM.isUserAuthenticated == .signedIn {
                        Button {
                            userVM.logOut()
                            gameVM.deconstructViewModel()
                        } label: {
                            Text("Log out")
                        }
                        .bold()
                    }
                    if userVM.isUserAuthenticated == .signedIn {
                        Button {
                            userVM.showDeletion.toggle()
                        } label: {
                            Text("Delete Account")
                                .foregroundColor(.red)
                        }
                        .sheet(isPresented: $userVM.showDeletion) {
                            DeleteView(user: userVM.user!)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
                .environmentObject(UserViewModel())
                .environmentObject(GameViewModel())
        }
    }
}
