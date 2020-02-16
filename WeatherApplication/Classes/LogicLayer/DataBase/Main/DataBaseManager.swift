//
//  DataBaseManager.swift
//
//  Created by Mikhail G. on 14/10/2019.
//  Copyright © 2019 mg. All rights reserved.
//

import Foundation
import CoreData

class DataBaseManager: NSObject{
    static let sharedInstance = DataBaseManager()
      
    private let persistentContainer: NSPersistentContainer = {
        let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel.init(contentsOf: modelURL!)
        let persistentContainer = NSPersistentContainer.init(name: "DataContainer", managedObjectModel: managedObjectModel!)
        persistentContainer.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error{
                print("Error while init datastore \(error.localizedDescription)")
            }
        })
        return persistentContainer
    }()
    
    func viewContext() -> NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void){
        persistentContainer.performBackgroundTask(block)
    }
    
    func fetchEntities(entityName: String, context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [NSManagedObject]{
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do
        {
            let results = try context.fetch(request) as! [NSManagedObject]
            return results
        }
        catch
        {
            print("Error with request: \(error)")
            return []
        }
    }
    
    func createModel(entityName: String, context: NSManagedObjectContext) -> NSManagedObject?{
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
    }
    
    func saveContext(context: NSManagedObjectContext){
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
