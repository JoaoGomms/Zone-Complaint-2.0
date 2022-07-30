//
//  ViewController.swift
//  Zone Complaint 2.0
//
//  Created by Joao Gomms on 19/07/22.
//

import UIKit

class ComplaintViewController: UIViewController {
    
    @IBOutlet weak var textLabelName: UILabel!
    @IBOutlet weak var textLabelAddress: UILabel!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var textFieldDescription: UITextView!
    var complaint: Complaint?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let complaintFormViewController = segue.destination as? ComplaintFormViewController  {
            complaintFormViewController.complaint = complaint
        }
    }
    
    func prepareScreen(){
        if let complaint = complaint {
            textLabelName.text = complaint.name
            textLabelAddress.text = complaint.address
            textFieldDescription.text = complaint.desc
            
            if let image = complaint.imagePhoto {
                imageViewPhoto.image = UIImage(data: image)

            }
            
        }
    }

    
}

