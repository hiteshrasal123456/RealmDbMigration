//
//  AppDelegate.swift
//  RealmMigrationTuto
//
//  Created by Tejora on 24/02/20.
//  Copyright © 2020 Tejora. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var realmObj : Realm?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupRealmDb()
        return true
    }
    
    func setupRealmDb() {
        /*
         follow steps -
         1. go to appDelegate set schemaVersion to 1 and if oldSchemaVersion < 1
         2. go to appDelegate comment below lines of code -
            migration.enumerateObjects(ofType: Person.className()) { (_, newPerson) in
                newPerson?["lastName1"] = ""
            }
         3. go to Person.swift file and comment below line of code -
         @objc  dynamic var lastName1 = ""
         4. go to ViewController.swift file and comment below line of code
         obj.lastName1 = "Rasala"
         5.Run the app
         
         6. now migration of db is require because we are adding property lastName1 to existing class Person
         7. go to Person.swift file and uncomment below line of code -
         @objc  dynamic var lastName1 = ""
         8.go to appDelegate uncomment below lines of code -
         migration.enumerateObjects(ofType: Person.className()) { (_, newPerson) in
             newPerson?["lastName1"] = ""
         }
         9.go to appDelegate set schemaVersion to 2 and if oldSchemaVersion < 2
         Note every time if you add or remove properties from real model. everytime you have to increment schemaVersion by 1
         10. run the app, check the db it will show new property
         */
        
        
        var configuration = Realm.Configuration(schemaVersion: 2, migrationBlock: { (migration, oldSchemaVersion) in
            print("version \(oldSchemaVersion)")
            if oldSchemaVersion < 2 {
               migration.enumerateObjects(ofType: Person.className()) { (_, newPerson) in
                   newPerson?["lastName1"] = ""
               }
            }
            })
        configuration.encryptionKey = createEncryptKey()
        
        configuration.fileURL = configuration.fileURL?.deletingLastPathComponent().appendingPathComponent("newName").appendingPathExtension("realm")
        Realm.Configuration.defaultConfiguration = configuration
        realmObj = try! Realm(configuration: configuration)
        print("file path is \(configuration.fileURL)")
    }
    
    func createEncryptKey() -> Data {
           let strForKey =  "1234567890asdfghjklqzxcvbnmzxcqwertyuiopasdfghjklpqwertyuiopq11r"
           let dataArray = strForKey.data(using:String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
           print("encrypted hexdecimal value \(dataArray.hexEncodedString())")
           return dataArray
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

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
