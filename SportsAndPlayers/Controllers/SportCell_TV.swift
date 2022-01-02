//
//  SportCell_TV.swift
//  SportsAndPlayers
//
//  Created by Atheer Alahmari on 25/05/1443 AH.
//

import UIKit
import CoreData
class SportCell_TV: UITableViewCell {
    
    @IBOutlet weak var addImage_Btn: UIButton!
    @IBOutlet weak var sportName_Label: UILabel!
    @IBOutlet weak var sportImage_Image: UIImageView!
    
    var delegate:ImageDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func sendData(image_Data : Data?){
        if let image_Data = image_Data {
            sportImage_Image.image = UIImage(data: image_Data)
            
        }
    }
    @IBAction func addImage_Action(_ sender: UIButton) {
        delegate?.addImage(sportCell_control: self)
        
    }
}


