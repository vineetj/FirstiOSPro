//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Vineet Jain on 17/08/18.
//  Copyright © 2018 Vineet Jain. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appdelegate = UIApplication.shared.delegate as! AppDelegate;
        
        let context = appdelegate.persistentContainer.viewContext;

        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
        for i in 1...10
        {
            let newUser = NSManagedObject(entity: entity!, insertInto: context)

            newUser.setValue("vineet", forKey: "username")
            newUser.setValue("\(i)", forKey: "password")
            newUser.setValue("12", forKey: "age")
        }
        
        
        
        do{
            try context.save()
        }
        catch{
            print("saving failed");
        }
    }

    @IBAction func ButtonAction(_ sender: Any) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate;
        
        let context = appdelegate.persistentContainer.viewContext;

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let sort = NSSortDescriptor(key: "password", ascending: false, selector:#selector(NSString.localizedStandardCompare(_:)));
            request.sortDescriptors = [sort]
            let result = try context.fetch(request);
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "password") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

