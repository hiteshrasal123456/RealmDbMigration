//
//  ViewController.swift
//  RealmMigrationTuto
//
//  Created by Tejora on 24/02/20.
//  Copyright © 2020 Tejora. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        save()
    }

    func save() {
        DispatchQueue.main.async {
            let realm = try! Realm()
            realm.beginWrite()
            let obj = Person()
            obj.id = 4
            obj.name = "hitesh44"
            obj.lastName = "Rasal"
            obj.lastName1 = "Rasala"
            realm.add(obj, update: .all)
            do {
               try realm.commitWrite()
            }catch let error {
                print("error is \(error)")
            }
        }
    }
    
    
}

