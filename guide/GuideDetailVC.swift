//
//  GuideDetailVC.swift
//  guide
//
//  Created by Laptop on 2021-04-14.
//

import UIKit
import CoreData

class GuideDetailVC: UIViewController
{

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    var selectedGuide: Guides? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedGuide != nil)
        {
            titleTF.text = selectedGuide?.title
            descTV.text = selectedGuide?.desc
        }
        
    }

    @IBAction func saveAction(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedGuide == nil)
            {
            let entity = NSEntityDescription.entity(forEntityName: "Guides", in: context)
            let newGuides = Guides(entity: entity!, insertInto: context)
            newGuides.id = guideList.count as NSNumber
            newGuides.title = titleTF.text
            newGuides.desc = descTV.text
            do{
                try context.save()
                guideList.append(newGuides)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("context save error")
            }
         }
        else //edit
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Guides")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for results in results
                {
                    let guides = results as! Guides
                    if(guides == selectedGuide)
                    {
                        guides.title = titleTF.text
                        guides.desc = descTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                    
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
  }
    @IBAction func DeleteGuide(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Guides")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for results in results
            {
                let guides = results as! Guides
                if(guides == selectedGuide)
                {
                    guides.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
                
            }
        }
        catch
        {
            print("Fetch Failed")
        }
    }
}

