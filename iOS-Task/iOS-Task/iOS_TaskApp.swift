//
//  iOS_TaskApp.swift
//  iOS-Task
//
//  Created by Kullanici on 26.02.2023.
//
import SwiftUI

@main
struct iOS_TaskApp: App {
    
    let persistenceController = PersistenceController.shared
    let appDelegate = AppDelegate()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(appDelegate.networkManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    let networkManager = NetworkManager()
    
    override init() {
        super.init()
        networkManager.fetchData(context: NSManagedObjectContext)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("\n-------> applicationDidFinishLaunching")
        return true
    }
}


//import SwiftUI
//
//@main
//struct iOS_TaskApp: App {
//
//    let persistenceController = PersistenceController.shared
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//
//        }
//    }
//}
//class AppDelegate : NSObject, UIApplicationDelegate {
//    @StateObject var networkManager = NetworkManager()
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        print("\n-------> applicationDidFinishLaunching")
//        networkManager.login()
//        return true
//    }
//}
