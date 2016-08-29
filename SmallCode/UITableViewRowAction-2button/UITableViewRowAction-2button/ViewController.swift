import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var myTableView: UITableView  =   UITableView()
  var itemsToLoad: [String] = ["One", "Two", "Three"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    // Get main screen bounds
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    
    myTableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    myTableView.dataSource = self
    myTableView.delegate = self
    
    myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    
    self.view.addSubview(myTableView)
    
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return itemsToLoad.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
    
    cell.textLabel?.text = self.itemsToLoad[indexPath.row]
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    print("User selected table row \(indexPath.row) and item \(itemsToLoad[indexPath.row])")
  }
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    
    let shareAction = UITableViewRowAction(style: .Normal, title: "Share") { (rowAction, indexPath) in
      
      print("Share action button is tapped for\(self.itemsToLoad[indexPath.row])")
      
      //pass indexPath, so we know which row we tapped
      self.displayActionSheet(indexPath)
    }
    
    //you can change the button color
    shareAction.backgroundColor = UIColor.cyanColor()
    
    let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (rowAction, indexPath) in
      print("Delete action button is tapped")
    }
    
    return [shareAction, deleteAction]
  }
  
  func displayActionSheet(indexPath: NSIndexPath) {
    let alertController = UIAlertController(title: "Action Sheet", message: "What would you like to do?", preferredStyle: .ActionSheet)
    
    let facebookShare = UIAlertAction(title: "Share via FaceBook", style: .Default, handler: { (action) -> Void in
      print("Ok button tapped")
    })
    
    let  emailShare = UIAlertAction(title: "Share via email", style: .Default, handler: { (action) -> Void in
      print("Delete button tapped")
    })
    
    let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
      print("Cancel button tapped")
      
      //Cancel button will dismiss the action sheet and close the slide option
      self.myTableView.setEditing(false, animated: true)
    })
    
    
    alertController.addAction(facebookShare)
    alertController.addAction(emailShare)
    alertController.addAction(cancelButton)
    
    self.navigationController!.presentViewController(alertController, animated: true, completion: nil)
  }
}