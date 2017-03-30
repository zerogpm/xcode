//
//  MasterViewController.swift
//  Borrowmatic
//
//  Created by Jian Su on 2017-03-28.
//  Copyright © 2017 ZeroTech. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  
  var detailViewController: DetailViewController? = nil
  var managedObjectContext: NSManagedObjectContext? = nil
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }
  
  // MARK: - Fetched results controller
  
  var fetchedResultsController: NSFetchedResultsController<BorrowItem> {
    if _fetchedResultsController != nil {
      return _fetchedResultsController!
    }
    
    let fetchRequest: NSFetchRequest<BorrowItem> = BorrowItem.fetchRequest()
    
    // Set the batch size to a suitable number.
    fetchRequest.fetchBatchSize = 20
    
    // Edit the sort key as appropriate.
    let sortDescriptor = NSSortDescriptor(key: "endDate", ascending: true)
    
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
    aFetchedResultsController.delegate = self
    _fetchedResultsController = aFetchedResultsController
    
    do {
      try _fetchedResultsController!.performFetch()
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
    
    return _fetchedResultsController!
  }
  
  var _fetchedResultsController: NSFetchedResultsController<BorrowItem>? = nil
  
  // MARK: - Table View
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return self.fetchedResultsController.sections?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionInfo = self.fetchedResultsController.sections![section]
    return sectionInfo.numberOfObjects
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let borrowItemObject = self.fetchedResultsController.object(at: indexPath)
    
    configureCell(cell, withBorrowItem: borrowItemObject)
    
    return cell
  }
  
  func configureCell(_ cell: UITableViewCell, withBorrowItem borrowItem: BorrowItem) {
    cell.textLabel?.text = borrowItem.title
    if let availableImageData = borrowItem.image as? Data {
      cell.imageView?.image = UIImage(data: availableImageData)
    }
  }
  
  // MARK: - Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let object = self.fetchedResultsController.object(at: indexPath)
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailItem = object
        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }
  
  /*
   func insertNewObject(_ sender: Any) {
   let context = self.fetchedResultsController.managedObjectContext
   let newEvent = Event(context: context)
   
   // If appropriate, configure the new managed object.
   newEvent.timestamp = NSDate()
   
   // Save the context.
   do {
   try context.save()
   } catch {
   // Replace this implementation with code to handle the error appropriately.
   // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
   let nserror = error as NSError
   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
   }
   }
   
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   let context = self.fetchedResultsController.managedObjectContext
   context.delete(self.fetchedResultsController.object(at: indexPath))
   
   do {
   try context.save()
   } catch {
   // Replace this implementation with code to handle the error appropriately.
   // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
   let nserror = error as NSError
   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
   }
   }
   }
   
   func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
   self.tableView.beginUpdates()
   }
   
   func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
   switch type {
   case .insert:
   self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
   case .delete:
   self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
   default:
   return
   }
   }
   
   func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
   switch type {
   case .insert:
   tableView.insertRows(at: [newIndexPath!], with: .fade)
   case .delete:
   tableView.deleteRows(at: [indexPath!], with: .fade)
   case .update:
   self.configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
   case .move:
   tableView.moveRow(at: indexPath!, to: newIndexPath!)
   }
   }
   
   func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
   self.tableView.endUpdates()
   }
   
   /*
   // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
   
   func controllerDidChangeContent(controller: NSFetchedResultsController) {
   // In the simplest, most efficient, case, reload the table view.
   self.tableView.reloadData()
   }
   */
   */
}

