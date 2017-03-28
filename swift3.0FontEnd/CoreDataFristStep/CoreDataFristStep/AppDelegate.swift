//
//  AppDelegate.swift
//  CoreDataFristStep
//
//  Created by Jian Su on 2017-03-25.
//  Copyright © 2017 ZeroTech. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let moc = persistentContainer.viewContext
    
    let notebookRequest:NSFetchRequest<Notebook> = Notebook.fetchRequest()
    notebookRequest.returnsObjectsAsFaults = false
    
    let keyPath = "title"
    let searchString = "Lagre"
    let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
    let notebookPredicate = NSPredicate(format: "%K CONTAINS %@", keyPath, searchString)
    
    notebookRequest.sortDescriptors = [sortDescriptor]
    notebookRequest.predicate = notebookPredicate
    
    var notebookArray = [Notebook]()
    
    do {
      notebookArray = try moc.fetch(notebookRequest)
    }catch {
      print(error)
    }
    
    for notebook in notebookArray {
      print("This is a notebook named \(notebook.title!) and it created at: \(notebook.createdAt!)")
      displayNotes(notebook: notebook)
    }
    
    /*let notebookObject = Notebook(context: moc)
    notebookObject.title = "Lagre NoteBook"
    notebookObject.createdAt = NSDate()
    
    for index in 1...25 {
      
      let noteObject = Note(context: moc)
      noteObject.content = "Interesting stuff numbe: \(index)"
      noteObject.title = "Interesting Title number: \(index)"
      noteObject.createdAt = NSDate()
      
      notebookObject.addToNote(noteObject)
      
    }
    
    try! moc.save()*/
    
    return true
  }
  
  func displayNotes (notebook:Notebook) {
    
    if let noteList = notebook.note as? Set<Note> {
      
      let sortedNotesArray = noteList.sorted(by: { (noteA:Note, noteB:Note) -> Bool in
        return noteA.createdAt!.compare(noteB.createdAt! as Date) == ComparisonResult.orderedAscending
      })
      
      for note in sortedNotesArray {
        print(note.title!)
      }
    }
    
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    saveContext()
  }
  
  // MARK: Core Data Stack
  
  lazy var persistentContainer:NSPersistentContainer = {
    let container = NSPersistentContainer(name: "FirstStepDataModel")
    container.loadPersistentStores(completionHandler: { (storeDescription:NSPersistentStoreDescription, error:Error?) in
      if let error = error as NSError? {
        print(error.localizedDescription)
      }
    })
    
    return container
    
  }()
  
  func saveContext() {
    let context = persistentContainer.viewContext
    
    if context.hasChanges {
      do {
        try context.save()
      }catch {
        print(error.localizedDescription)
      }
    }
  }
  
  
}

