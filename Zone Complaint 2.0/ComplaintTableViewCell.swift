//
//  ComplaintTableViewCell.swift
//  Zone Complaint 2.0
//
//  Created by Joao Gomms on 26/07/22.
//

import UIKit

class ComplaintTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(_ complaint: Complaint){
        textLabel?.text = complaint.name
        detailTextLabel?.text = complaint.createdAt?.formatted(.dateTime)
        
    }

}
