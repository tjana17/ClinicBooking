//
//  ClinicBookingApp.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 01/09/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct ClinicBookingApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SplashViewCoordinator()
        }
    }
}

struct AppRootView: View {
    //    @EnvironmentObject var userSession: UserSession  // Use the shared session
    @State var isAuthenticated: Bool = false

    var body: some View {
        NavigationStack {
            if isAuthenticated {
                HomeDashboard()
                    .navigationBarBackButtonHidden(true)
            } else {
                LoginView()
            }
        }
        .onAppear(perform: checkUserAuthentication)
    }
    private func checkUserAuthentication() {
        if let user = Auth.auth().currentUser {
            print("Found current user: \(user.uid), email \(String(describing: user.email))")
            fetchOrCreateUser(uid: user.uid, email: user.email)
        } else {
            print("No current user found.")
        }
    }
    private func fetchOrCreateUser(uid: String, email: String?) {
        // Fetch the user's data from your app's server or create a new record if it doesn't exist
        let defaults =  UserDefaults.standard.value(AppUser.self, forKey: "userDetails")
        if let mail = defaults?.email {
            isAuthenticated = email == mail.lowercased() ? true : false
        }
        debugPrint("Defaults == \(String(describing: defaults))")
    }
}
