//
//  SportCell_TV.swift
//  SportsAndPlayers
//
//  Created by Atheer Alahmari on 25/05/1443 AH.
//

import UIKit

class SportCell_TV: UITableViewCell {

    @IBOutlet weak var addImage_Btn: UIButton!
    @IBOutlet weak var sportName_Label: UILabel!
    
    @IBOutlet weak var sportImage_Image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addImage_Action(_ sender: UIButton) {
        addImage_Btn.isHidden = true
        sportImage_Image.isHidden = false
//        guard let data = image_UI else {return}
//        
//        var img = UIImage(data: data)
//        image_UI.setImage(UIImage(data: data) , for: .normal)
//        
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.sourceType = .photoLibrary
//            imagePickerController.delegate = self
//            self.present(imagePickerController, animated: true, completion: nil)
//        }
//        
        
//        image_UI.setImage(UIImage(systemName: "person"), for: .normal)
//        image_UI.titleLabel?.isHidden = true
    }
}
extension SportCell_TV: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        let image = info[.originalImage] as? UIImage
//        image_UI.setImage(image, for: .normal)
//        picker.dismiss(animated: true, completion: nil)
    }
}
