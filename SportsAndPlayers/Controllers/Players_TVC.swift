//
//  Players_TVC.swift
//  SportsAndPlayers
//
//  Created by Atheer Alahmari on 25/05/1443 AH.
//

import UIKit
import CoreData
class Players_TVC: UITableViewController {
    
    var sportName : String?
    var sportObj:Sports?
    var listPlayerInfo :[Players] = []
    var name = ""
    var age = ""
    var hight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sportObj?.sportName
        
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(addPlayer))
        //        
        fetchData()
    }
    // MARK: -----------------------------------------------------------------
    func fetchData() {
        let context = getContext()
        
        let request = NSFetchRequest<Players>.init(entityName: "Players")
        
        do {
            let reselt = try context.fetch(request)
            listPlayerInfo = reselt
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    @IBAction func addNewPlayer(_ sender: UIBarButtonItem) {
        let alertVC = UIAlertController.init(title: "New Player ", message: "add a new player", preferredStyle: .alert)
        
        alertVC.addTextField { (textName) in
            textName.placeholder = "Enter First and Last Name"
        }
        alertVC.addTextField { (textAge) in
            textAge.placeholder = "Enter Age"
            
        }
        alertVC.addTextField { (textHeight) in
            textHeight.placeholder = "Enter Height"
            
        }
        alertVC.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction.init(title: "Save", style: .default, handler:{ [self, weak alertVC] (_) in
            
            let name_TF = alertVC?.textFields![0] // Force unwrapping because we know it exists.
            let age_TF = alertVC?.textFields![1] // Force unwrapping because we know it exists.
            let height_TF = alertVC?.textFields![2] // Force unwrapping because we know it exists.
            
            
            let context = getContext()
            let player = Players(context: context)
            player.playerName = name_TF!.text!
            player.playerAge = age_TF!.text!
            player.playerHieght = height_TF!.text!
            
            sportObj?.addToPlayer(player)
            do {
                try context.save()
                fetchData()
            } catch {
                print(error.localizedDescription)
            }
            
            
            
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let playerArr = sportObj?.player {
            return playerArr.count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID_PlayerCell", for: indexPath)
        
        if let playerArr = sportObj?.player?.allObjects as? [Players] {
            let playerObj = playerArr[indexPath.row]
            cell.textLabel?.text = "\(playerObj.playerName!) - Age: \(playerObj.playerAge!), Height: \(playerObj.playerHieght!)"
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let alertVC = UIAlertController.init(title: "Edit Sport", message: "Edit Sport", preferredStyle: .alert)
        alertVC.addTextField { [self] (textName) in
            if let playerArr = sportObj?.player?.allObjects as? [Players] {
                let playerObj = playerArr[indexPath.row]
                
                textName.text = playerObj.playerName
                
            }
        }
        alertVC.addTextField { [self] (textName) in
            if let playerArr = sportObj?.player?.allObjects as? [Players] {
                let playerObj = playerArr[indexPath.row]
                
                textName.text = playerObj.playerAge
            }
        }
        alertVC.addTextField { [self] (textName) in
            if let playerArr = sportObj?.player?.allObjects as? [Players] {
                let playerObj = playerArr[indexPath.row]
                
                textName.text = playerObj.playerHieght
            }
        }
        alertVC.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction.init(title: "Save", style: .default, handler:{ [self, weak alertVC] (_) in
            
            
            
            let textname = alertVC?.textFields![0] // Force unwrapping because we know it exists.
            let textage = alertVC?.textFields![1]
            let texthight = alertVC?.textFields![2]
            
            if let playerArr = sportObj?.player?.allObjects as? [Players] {
                let playerObj = playerArr[indexPath.row]
                playerObj.playerName = textname!.text!
                playerObj.playerAge = textage!.text!
                playerObj.playerHieght = texthight!.text!
            }
            let context = getContext()
            do {
                try context.save()
                fetchData()
            } catch {
                print(error.localizedDescription)
            }
            
            
            
            
        }))
        self.present(alertVC, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = getContext()
        if let playerArr = sportObj?.player?.allObjects as? [Players] {
            let playerObj = playerArr[indexPath.row]
            
            context.delete(playerObj)
        }
        do {
            try context.save()
            fetchData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
