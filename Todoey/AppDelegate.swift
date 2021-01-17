//
//  AppDelegate.swift
//  Todoey
//
//  Created by Indra on 15/01/21.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //  MARK: Imprime o diretorio do simulador para poder ir ate on o arquivo defaults esta armazenado
        /*
         Users/indra/Library/Developer/CoreSimulator/Devices/E5383744-5174-40F8-8AB5-4394F0EE0F7A/data/Containers/
         Data/Application/DA8428A7-D35F-467D-B6B8-44D42F1BE6A1/Library/Preferences/com.bfcodeofficial.Todoey.plist
         */
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

