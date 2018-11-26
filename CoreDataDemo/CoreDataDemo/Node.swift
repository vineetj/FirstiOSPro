//
//  Node.swift
//  CoreDataDemo
//
//  Created by Vineet Jain on 02/10/18.
//  Copyright © 2018 Vineet Jain. All rights reserved.
//

import Foundation

class Node{
    var nodeObjNext:Node?
    var nodeVal:Int
    
    init(_ nodeval:Int)
    {
        self.nodeVal = nodeval
    }
}

class LinkedList{
    var head:Node?

    init(head:Node?)
    {
        self.head = head
    }
    
    func append(_ node: Node) {
        
        guard head != nil else {
            head = node
            return
        }
        
        var current = head
        while let _ = current?.nodeObjNext{
            current = current?.nodeObjNext
        }
        current?.nodeObjNext = node
    }
    
    func AppendNode(_ node:Node)
    {
//    let node1 = Node(1)
//    let node2 = Node(2)
//    node1.nodeObjNext = node2
        
        if let head1 = head
        {
          var currentNode = head
            while currentNode?.nodeObjNext != nil
            {
                currentNode = currentNode?.nodeObjNext
            }
            currentNode?.nodeObjNext = node
        }
        else
        {
            head = node
            return
        }
        //while cu
        
    }
    func insertNode(_ node: Node, atPosition: Int) {
        var posIndex = 1
        guard head != nil else{
            head = node
            return
        }
        
        var CurrentNode = head
        while let _ = CurrentNode?.nodeObjNext
        {
            if posIndex == atPosition
            {
                CurrentNode?.nodeObjNext = node
            }
            posIndex += 1
        }
    }
    func getNode(atPosition position: Int) -> Node? {
        
        var currentNode = head
        var currentIndex:Int = 1
        
        while let _ = currentNode?.nodeObjNext
        {
            if currentIndex == position
            {
                
                return currentNode
            }
            
            currentIndex += 1
            currentNode = currentNode?.nodeObjNext

        }
        return nil
    }
    
    func AddSampleData()
    {
    let n1 = Node(1)
    let n2 = Node(2)
    let n3 = Node(3)
    let n4 = Node(4)
    
    // Start setting up a LinkedList
    let ll = LinkedList(head: n1)
    AppendNode(n2)
    AppendNode(n3)
    print(ll.head!.nodeObjNext?.nodeObjNext?.nodeVal) // Should print 3
    }
}
