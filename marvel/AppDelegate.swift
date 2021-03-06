//
//  AppDelegate.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 30/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favorites")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


//Marvel Public Key 2f63d6c20dbbf54179db421f8af36bf4
//Marvel Private Key 3f5e2a68fe6eee27bcd406603f983cbaf30a0df1
//private+public 3f5e2a68fe6eee27bcd406603f983cbaf30a0df12f63d6c20dbbf54179db421f8af36bf4


//Chamada https://gateway.marvel.com:443/v1/public/characters?hash=bc28cae76267fa2378b2d26280a8fe9c&ts=1609424333.442628&limit=3&offset=10&orderBy=name


/*
 
 func MD5(string: String) -> Data {
     let messageData = string.data(using:.utf8)!
     var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

     _ = digestData.withUnsafeMutableBytes {digestBytes in
         messageData.withUnsafeBytes {messageBytes in
             CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
         }
     }

     return digestData
 }

 print("Hello World")
 let timestamp = NSDate().timeIntervalSince1970
 print(timestamp)
 print(MD5("\(timestmp)3f5e2a68fe6eee27bcd406603f983cbaf30a0df12f63d6c20dbbf54179db421f8af36bf4)")
 */



/*
 
 Modelo do character:
 
 data -> results -> id (characterId) ex: 1011334
 data -> results -> name ex: 3-D Man
 data -> results -> thumbnail.path + thumbnail.extension
 
 */
//GET CHARACTERS EXAMPLE


//pode incluir parametros ?limit=20&offset=0
/*
 {
 "code": 200,
 "status": "Ok",
 "copyright": "© 2020 MARVEL",
 "attributionText": "Data provided by Marvel. © 2020 MARVEL",
 "attributionHTML": "<a href=\"http://marvel.com\">Data provided by Marvel. © 2020 MARVEL</a>",
 "etag": "449386bf7426b9d20aa5d6d817052eb4cb2e6746",
 "data": {
     "offset": 0,
     "limit": 20,
     "total": 1493,  ---> Da pra saber quantas paginas tem com isto
     "count": 20,
     "results": [
         {
             "id": 1011334,
             "name": "3-D Man",
             "description": "",
             "modified": "2014-04-29T14:18:17-0400",
             "thumbnail": {
                 "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                 "extension": "jpg"
             },
             "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011334",
             "comics": {
                 "available": 12,
                 "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/comics",
                 "items": [
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/21366",
                         "name": "Avengers: The Initiative (2007) #14"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/24571",
                         "name": "Avengers: The Initiative (2007) #14 (SPOTLIGHT VARIANT)"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/21546",
                         "name": "Avengers: The Initiative (2007) #15"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/21741",
                         "name": "Avengers: The Initiative (2007) #16"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/21975",
                         "name": "Avengers: The Initiative (2007) #17"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/22299",
                         "name": "Avengers: The Initiative (2007) #18"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/22300",
                         "name": "Avengers: The Initiative (2007) #18 (ZOMBIE VARIANT)"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/22506",
                         "name": "Avengers: The Initiative (2007) #19"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/8500",
                         "name": "Deadpool (1997) #44"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/10223",
                         "name": "Marvel Premiere (1972) #35"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/10224",
                         "name": "Marvel Premiere (1972) #36"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/comics/10225",
                         "name": "Marvel Premiere (1972) #37"
                     }
                 ],
                 "returned": 12
             },
             "series": {
                 "available": 3,
                 "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/series",
                 "items": [
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/series/1945",
                         "name": "Avengers: The Initiative (2007 - 2010)"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/series/2005",
                         "name": "Deadpool (1997 - 2002)"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/series/2045",
                         "name": "Marvel Premiere (1972 - 1981)"
                     }
                 ],
                 "returned": 3
             },
             "stories": {
                 "available": 21,
                 "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/stories",
                 "items": [
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/19947",
                         "name": "Cover #19947",
                         "type": "cover"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/19948",
                         "name": "The 3-D Man!",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/19949",
                         "name": "Cover #19949",
                         "type": "cover"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/19950",
                         "name": "The Devil's Music!",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/19951",
                         "name": "Cover #19951",
                         "type": "cover"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/19952",
                         "name": "Code-Name:  The Cold Warrior!",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/47184",
                         "name": "AVENGERS: THE INITIATIVE (2007) #14",
                         "type": "cover"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/47185",
                         "name": "Avengers: The Initiative (2007) #14 - Int",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/47498",
                         "name": "AVENGERS: THE INITIATIVE (2007) #15",
                         "type": "cover"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/47499",
                         "name": "Avengers: The Initiative (2007) #15 - Int",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/47792",
                         "name": "AVENGERS: THE INITIATIVE (2007) #16",
                         "type": "cover"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/47793",
                         "name": "Avengers: The Initiative (2007) #16 - Int",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/48361",
                         "name": "AVENGERS: THE INITIATIVE (2007) #17",
                         "type": "cover"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/48362",
                         "name": "Avengers: The Initiative (2007) #17 - Int",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/49103",
                         "name": "AVENGERS: THE INITIATIVE (2007) #18",
                         "type": "cover"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/49104",
                         "name": "Avengers: The Initiative (2007) #18 - Int",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/49106",
                         "name": "Avengers: The Initiative (2007) #18, Zombie Variant - Int",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/49888",
                         "name": "AVENGERS: THE INITIATIVE (2007) #19",
                         "type": "cover"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/49889",
                         "name": "Avengers: The Initiative (2007) #19 - Int",
                         "type": "interiorStory"
                     },
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/stories/54371",
                         "name": "Avengers: The Initiative (2007) #14, Spotlight Variant - Int",
                         "type": "interiorStory"
                     }
                 ],
                 "returned": 20
             },
             "events": {
                 "available": 1,
                 "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/events",
                 "items": [
                     {
                         "resourceURI": "http://gateway.marvel.com/v1/public/events/269",
                         "name": "Secret Invasion"
                     }
                 ],
                 "returned": 1
             },
             "urls": [
                 {
                     "type": "detail",
                     "url": "http://marvel.com/characters/74/3-d_man?utm_campaign=apiRef&utm_source=2f63d6c20dbbf54179db421f8af36bf4"
                 },
                 {
                     "type": "wiki",
                     "url": "http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=2f63d6c20dbbf54179db421f8af36bf4"
                 },
                 {
                     "type": "comiclink",
                     "url": "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=2f63d6c20dbbf54179db421f8af36bf4"
                 }
             ]
         },
 */
