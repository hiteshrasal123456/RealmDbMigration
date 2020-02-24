# RealmDbMigration
RealDb migration implementation step by step
# follow steps -
         1. install pod file which present in repo.Then go to appDelegate set schemaVersion to 1 and if oldSchemaVersion < 1
         2. go to appDelegate comment below lines of code -
            migration.enumerateObjects(ofType: Person.className()) { (_, newPerson) in
                newPerson?["lastName1"] = ""
            }
         3. go to Person.swift file and comment below line of code -
        /* @objc  dynamic var lastName1 = "" */
         4. go to ViewController.swift file and comment below line of code
         obj.lastName1 = "Rasala"
         5.Run the app
         
         6. now migration of db is require because we are adding property lastName1 to existing class Person
         7. go to Person.swift file and uncomment below line of code -
        /* @objc  dynamic var lastName1 = "" */
         8.go to appDelegate uncomment below lines of code -
         /* migration.enumerateObjects(ofType: Person.className()) { (_, newPerson) in
             newPerson?["lastName1"] = ""
         } */
         9.go to appDelegate set schemaVersion to 2 and if oldSchemaVersion < 2
         Note every time if you add or remove properties from real model. everytime you have to increment schemaVersion by 1
         10. run the app, check the db it will show new property
