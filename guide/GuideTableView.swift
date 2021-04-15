//
//  GuideTableView.swift
//  guide
//
//  Created by Laptop on 2021-04-14.
//

import UIKit
import CoreData

var guideList = [Guides]()

class GuideTableView: UITableViewController
{
    var firstLoad = true
    
    func nonDeletedGuides() -> [Guides]
    {
        var noDeleteGuideList = [Guides]()
        for guides in guideList
        {
            if (guides.deletedDate == nil)
            {
                noDeleteGuideList.append(guides)
            }
            
        }
            
            return noDeleteGuideList
    }
    
    override func viewDidLoad() {
        if(firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Guides")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for results in results
                {
                    let guides = results as! Guides
                    guideList.append(guides)
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let guideCell = tableView.dequeueReusableCell(withIdentifier: "guideCellID", for: indexPath) as! GuideCell
        
        let thisGuide: Guides!
        thisGuide = nonDeletedGuides()[indexPath.row]
        
        guideCell.titleLabel.text = thisGuide.title
        guideCell.descLabel.text = thisGuide.desc
        
        return guideCell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nonDeletedGuides().count
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editGuide", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "editGuide")
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let guideDetail = segue.destination as? GuideDetailVC
            
            let selectedGuide : Guides!
            selectedGuide = nonDeletedGuides()[indexPath.row]
            guideDetail!.selectedGuide = selectedGuide
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
