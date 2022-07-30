//
//  ComplaintTableViewController.swift
//  Zone Complaint 2.0
//
//  Created by Joao Gomms on 20/07/22.
//

import UIKit
import CoreData

class ComplaintTableViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<Complaint>!
    
    func loadComplaints(){
        let fetchRequest: NSFetchRequest<Complaint> = Complaint.fetchRequest()
        let dateSortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [dateSortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let complaintViewController = segue.destination as? ComplaintViewController, let indexPath = tableView.indexPathForSelectedRow {
            complaintViewController.complaint = fetchedResultsController.object(at: indexPath)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadComplaints()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?
                ComplaintTableViewCell else {
            return UITableViewCell()
            
        }
        let actualComplaint = fetchedResultsController.object(at: indexPath )
        
        cell.configureWith(actualComplaint)
        
    

        return cell
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete {
            let complaint = fetchedResultsController.object(at: indexPath)
            context.delete(complaint)
            try? context.save()
        }
        
    
    }

}


extension ComplaintTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}
