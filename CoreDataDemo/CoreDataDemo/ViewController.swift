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
        
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        var newArray:[String] = []
        
        var modval = 0;
        var divval = 0;
        var vale1 = ""
        for number in numbers
        {
            var num1 = number
            while num1 != 0 {
                modval = num1%10;
                num1 = num1/10;
                vale1 = digitNames[modval]!+vale1;
                //newArray.append(vale1)
            }
            newArray.append(vale1)
            
            vale1 = ""
        }
        var SomeArr:[[String : Any]] = []
        
        var someDict1:[String:Any] = ["name" : "Vineet", "age":22]
        var someDict2:[String:Any] = ["name" : "Vineet1", "age":25]
        var someDict3:[String:Any] = ["name" : "Vineet2", "age":12]
        var someDict4:[String:Any] = ["name" : "Vineet3", "age":33]

        SomeArr.append(someDict1);
        SomeArr.append(someDict2);
        SomeArr.append(someDict3);
        SomeArr.append(someDict4);
        
        var somesortArr = [1,44,2,24,98,4];
        example4(manatees: SomeArr)
        selectsort(somesortArr)
        
        let n1 = Node(1)
        let n2 = Node(2)
        let n3 = Node(3)
        let n4 = Node(4)
        
        // Start setting up a LinkedList
        let ll = LinkedList(head: n1)
        ll.append(n2)
        ll.append(n3)
        print(ll.head!.nodeObjNext?.nodeObjNext?.nodeVal) // Should print 3
        //var nodeval = ll.getNode(atPosition: 3)!.nodeVal
        ll.insertNode(n4,atPosition: 3)
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
    
    func example4(manatees: [[String : Any]]) {
        var oldestManatee = "No manatees here!"
        
        for manatee1 in manatees {
            for manatee2 in manatees {
                if (manatee1["age"] as! Int) < (manatee2["age"] as! Int) {
                    oldestManatee = manatee2["name"] as! String
                } else {
                    oldestManatee = manatee1["name"] as! String
                }
            }
        }
        print(oldestManatee)
    }
    
    func selectsort(_ selectSort:[Int])
    {
        var swp=0,minNum=0;
        var selectsort2 =  selectSort
        for num in 0..<selectSort.count
        {
            minNum = num;
            for num2 in num+1..<selectSort.count
            {
                if selectsort2[num2]<selectsort2[num]
                {
                    swp = selectsort2[num]
                    selectsort2[num] = selectsort2[num2]
                    selectsort2[num2] = swp
                }
            }
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

