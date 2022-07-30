//
//  ComplaintFormViewController.swift
//  Zone Complaint 2.0
//
//  Created by Joao Gomms on 26/07/22.
//

import UIKit

class ComplaintFormViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var textFieldAddress: UITextField!
    
    var complaint: Complaint?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let complaint = complaint{
            title = "Edit Complaint"
            textFieldName.text = complaint.name
            textFieldAddress.text = complaint.address
            textViewDescription.text = complaint.desc
            if let image = complaint.imagePhoto {
                imageViewPhoto.image = UIImage(data: image)

            }
        }
    }
    


    @IBAction func uploadPhoto(_ sender: Any) {
        let alert = UIAlertController(title: "Select Photo", message: "Choose the complaint photo from", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)

        }
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Photo Album", style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)
       
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        if complaint == nil {
            complaint = Complaint(context: context)
            complaint?.createdAt = Date.now
        }
        
        complaint?.name = textFieldName.text
        complaint?.imagePhoto = imageViewPhoto.image?.jpegData(compressionQuality: 0.9)
        complaint?.desc = textViewDescription.text
        complaint?.address = textFieldAddress.text
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
        
    }
}


extension ComplaintFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imageViewPhoto.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
