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
        NavigationView {
            List {
                // MARK: - Account Information
                Section(header: Text("Account Information")) {
                    Text("Username: \(userVM.user?.username ?? "No username found")")
                    Text("Name: \(userVM.user?.firstName ?? "No name found") \(userVM.user?.lastName ?? "")")
                    Text("Email: \(userVM.user?.email ?? "No email found")")
                }
                
                //MARK: - Logout/Delete Account Buttons
                HStack {
                    if userVM.isUserAuthenticated == .signedIn {
                        Button {
                            userVM.logOut()
                        } label: {
                            Text("Log out")
                        }
                        .bold()
                        .buttonStyle(.bordered)
                    }
                    Spacer()
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
            }
            .listStyle(GroupedListStyle())
//            .navigationBarTitle("Settings")
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
                .environmentObject(UserViewModel())
        }
    }
}
