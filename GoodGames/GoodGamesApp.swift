//
//  GoodGamesApp.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/20/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
// THIS THROWS AN ERROR, BUT I THINK I'LL NEED IT AT SOME POINT
import FirebaseStorage

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
#if EMULATORS
      print(
      """
      *******************************
      Testing on Emulators
      *******************************
      """
      )
      Auth.auth().useEmulator(withHost:"localhost", port:9099)
      Storage.storage().useEmulator(withHost:"localhost", port:9199)
      let settings = Firestore.firestore().settings
      settings.host = "localhost:8080"
      settings.isPersistenceEnabled = false
      settings.isSSLEnabled = false
      Firestore.firestore().settings = settings
#elseif DEBUG
      print(
      """
      *******************************
      Testing on Live Server
      *******************************
      """
      )
#endif
      return true
  }
}

@main
struct GoodGamesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationTabView().environmentObject(FirestoreManager())
        }
    }
}
