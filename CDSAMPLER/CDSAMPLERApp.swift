import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct CDSAMPLERApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
    init() {
        FirebaseApp.configure()
//        let db = Firestore.firestore()
//        print(db) // silence warning
        
//        let authState = AuthenticationState.shared
//        let contentView = SamplerView().environmentObject(authState)
    }
    
    
    var body: some Scene {
        WindowGroup {
            // Should be allowed with iOS14 lifecycle, injecting environment variable into view
            ContentView().environmentObject(AuthenticationState.shared)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchoptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("CD_SAMPLERAPP is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
        return true
    }
}

