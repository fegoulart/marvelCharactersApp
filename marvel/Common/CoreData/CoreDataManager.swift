//
//  CoreDataManager.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 06/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import CoreData
import PromiseKit


enum OperationType {
    case fetchAll, insert, delete
}

protocol CharactersReturnDataDecoder {
    
    static func setSuccessReturnType<T>(_ type: T.Type)  -> T
    static func charactersReturnDataDecode<T: Comparable>(_ type: T.Type, from data: [NSManagedObject])  -> T
}

struct DataToReturn:CharactersReturnDataDecoder {
    
    static func setSuccessReturnType<T>(_ type: T.Type) -> T  {
        let success = FavoriteSuccess.success
        return success as! T
    }
    
    static func charactersReturnDataDecode<T>(_ type: T.Type, from data: [NSManagedObject]) -> T  {
        return data as! T
    }
    
}


protocol GenericCoreDataAPI {
    static func callCoreData<T, U>(operationType: OperationType, entityName: String,dataReturnType: T.Type, keyValues: Dictionary<String,U>?) -> Promise<T>
    

}

struct CoreDataAPIManager:GenericCoreDataAPI {
    
    
    static func callCoreData<T, U>(operationType: OperationType, entityName: String, dataReturnType: T.Type, keyValues: Dictionary<String, U>? = [:]) -> Promise<T>  {
        
        return Promise { seal in
            
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    seal.reject(CharacterErrors.couldNotFindAppDelegate(error: "CoreDataAPIManager Error"))
                    return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
            
            switch operationType {
            case OperationType.insert:
                let newRow = NSManagedObject(entity: entity, insertInto: managedContext)
                if let newKeyValues = keyValues {
                    for (keyPath, value) in newKeyValues  {
                        newRow.setValue(value, forKey: keyPath)
                    }
                }
                do {
                    try managedContext.save()
                    let success = DataToReturn.setSuccessReturnType(dataReturnType)
                    try managedContext.save()
                    seal.fulfill(success)
                } catch let error as NSError {
                    seal.reject(error)
                }
            case OperationType.fetchAll:
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
                do {
                    let fetchedData = try managedContext.fetch(fetchRequest)
                    let dataToReturn = DataToReturn.charactersReturnDataDecode(dataReturnType, from: fetchedData)
                    seal.fulfill(dataToReturn)
                } catch let error as NSError {
                    seal.reject(error)
                }
                
            case OperationType.delete:
                if let newKeyValues = keyValues {
                    for (keyPath, value) in newKeyValues  {
                        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
                        fetchRequest.predicate = NSPredicate.init(format: "\(keyPath)==\(value)")
                        if let result = try? managedContext.fetch(fetchRequest) {
                            for object in result {
                                managedContext.delete(object)
                            }
                        }
                    }
                    do {
                        try managedContext.save()
                        
                    } catch let error as NSError {
                        seal.reject(error)
                    }
                    let success = DataToReturn.setSuccessReturnType(dataReturnType)
                    seal.fulfill(success)
                    
                }
                
            }
        }
        
    }
}



