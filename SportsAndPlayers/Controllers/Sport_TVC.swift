//
//  Sport_TVC.swift
//  SportsAndPlayers
//
//  Created by Atheer Alahmari on 25/05/1443 AH.
//

import UIKit
import CoreData
class Sport_TVC: UITableViewController {
    var listSportName:[Sports] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.rowHeight = 100
        
        //navigationController?.navigationItem.title = "yy"
        fetchData()
    }
    
    // MARK: -----------------------------------------------------------------
    func fetchData() {
        let context = getContext()
        
        let request = NSFetchRequest<Sports>.init(entityName: "Sports")
        
        do {
            let reselt = try context.fetch(request)
            listSportName = reselt
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
    
    //MARK: Action Btn --------------------------addNewSport -------------------------------------------
    @IBAction func addNewSport(_ sender: UIBarButtonItem) {
        
        let alertVC = UIAlertController.init(title: "New Sport ", message: "add a new sport", preferredStyle: .alert)
        
        alertVC.addTextField { (textName) in
            
        }
        
        alertVC.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction.init(title: "Save", style: .default, handler:{ [self, weak alertVC] (_) in
            let textField = alertVC?.textFields![0] // Force unwrapping because we know it exists.
            
            let context = getContext()
            let sport = Sports(context: context)
            sport.sportName = textField!.text!
            listSportName.append(sport)
            
            do {
                try context.save()
                fetchData()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        self.present(alertVC, animated: true, completion: nil)
        
        
    }
    
    //MARK: ---------------------------------------tableView------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSportName.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID_SportCell", for: indexPath) as! SportCell_TV
        
        let sport = listSportName[indexPath.row]
        cell.sportName_Label.text = sport.sportName
        
        //
        //        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        //            let imagePickerController = UIImagePickerController()
        //            imagePickerController.sourceType = .photoLibrary
        //            imagePickerController.delegate = self
        //            self.present(imagePickerController, animated: true, completion: nil)
        //        }
        //
        
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        
        let alertVC = UIAlertController.init(title: "Edit Sport", message: "Edit Sport", preferredStyle: .alert)
        alertVC.addTextField { [self] (textName) in
            textName.text = listSportName[indexPath.row].sportName
        }
        
        alertVC.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction.init(title: "Save", style: .default, handler:{ [self, weak alertVC] (_) in
            
            let textField = alertVC?.textFields![0] // Force unwrapping because we know it exists.
            
            listSportName[indexPath.row].sportName = textField!.text!
            
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
        
        context.delete(listSportName[indexPath.row])
        do {
            try context.save()
            fetchData()
        } catch {
            print(error.localizedDescription)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playersDetalise_VC = self.storyboard!.instantiateViewController(withIdentifier:"Players_TVC") as! Players_TVC
        playersDetalise_VC.sportObj = listSportName[indexPath.row]
        
        self.navigationController?.pushViewController( playersDetalise_VC, animated: true)
        
        
    }
    
}
//extension Sport_TVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        let image = info[.originalImage] as? UIImage
//        image_UI.setImage(image, for: .normal)
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
