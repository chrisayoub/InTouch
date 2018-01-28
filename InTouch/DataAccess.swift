//
//  DataAccess.swift
//  InTouch
//
//  Created by Chris on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import Foundation
import CoreData

class DataAccess {
    
    static let shared = DataAccess()
    
    fileprivate init() {
    }
    
    static let minute: TimeInterval = 60.0
    static let hour: TimeInterval = 60.0 * minute
    static let day: TimeInterval = 24 * hour
    static let week: TimeInterval = 7 * day
    static let month: TimeInterval = 30 * day
    static let year: TimeInterval = 365 * day
  
    enum graphInterval {
        case week, month, year
    }
    
    // MARK: Public CoreData methods
    
    // Mind
    
    func addMindData(length: Double) {
        let mind = Mind()
        mind.date = getCurrentDate()
        mind.length = length
        insertEntity(entity: mind)
    }
    
    func getMindData(interval: graphInterval) -> [Mind] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Mind")
        let predicate = getBoundedPredicateFromInterval(interval: interval)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as! [Mind]
        } catch {
            return []
        }
    }
    
    // Sleep
    
    func addSleepData(hours: Int64) {
        let sleep = Sleep()
        sleep.date = getCurrentDate()
        sleep.hoursOfSleep = hours
        insertEntity(entity: sleep)
    }
    
    func getSleepData(interval: graphInterval) -> [Sleep] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sleep")
        let predicate = getBoundedPredicateFromInterval(interval: interval)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as! [Sleep]
        } catch {
            return []
        }
    }
    
    // Mood
    
    func addMoodData(moodVal: Int64) {
        let mood = Mood()
        mood.date = getCurrentDate()
        mood.moodVal = moodVal
        insertEntity(entity: mood)
    }
    
    func getMoodData(interval: graphInterval) -> [Mood] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Mood")
        let predicate = getBoundedPredicateFromInterval(interval: interval)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as! [Mood]
        } catch {
            return []
        }
    }
    
    // Goal
    
    func addGoalData(goalText: String) {
        let goal = Goal()
        goal.date = getCurrentDate()
        goal.text = goalText
        insertEntity(entity: goal)
    }
    
    func getGoalData(interval: graphInterval) -> [Goal] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        let predicate = getBoundedPredicateFromInterval(interval: interval)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as! [Goal]
        } catch {
            return []
        }
    }
    
    // Diet
    
    func addDietData(caffeine: Int64, hydration: Int64, junk: Int64, veggies: Int64) {
        let diet = Diet()
        diet.date = getCurrentDate()
        
        diet.caffeine = caffeine
        diet.hydartion = hydration
        diet.junk = junk
        diet.veggies = veggies
            
        insertEntity(entity: diet)
    }
    
    func getGoalData(interval: graphInterval) -> [Diet] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Diet")
        let predicate = getBoundedPredicateFromInterval(interval: interval)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as! [Diet]
        } catch {
            return []
        }
    }
    
    // MARK: Utility methods
    
    private func getBoundedPredicateFromInterval(interval: graphInterval) -> NSPredicate {
        var timeBound = Date()
        
        if (interval == .week) {
            timeBound.addTimeInterval(-DataAccess.week)
        } else if (interval == .month) {
            timeBound.addTimeInterval(-DataAccess.month)
        } else if (interval == .year) {
            timeBound.addTimeInterval(-DataAccess.year)
        }
        
        let timeVal = timeBound.timeIntervalSinceReferenceDate.bitPattern
        return NSPredicate(format: "%K >= %@", "date", timeVal)
    }
    
    private func insertEntity(entity: NSManagedObject) {
        persistentContainer.viewContext.insert(entity)
        saveContext()
    }
    
    private func getCurrentDate() -> Int64 {
        return (Int64) (Date().timeIntervalSinceReferenceDate.bitPattern)
    }
    
    private func decodeDate(forInterval: UInt64) -> Date {
        return Date(timeIntervalSinceReferenceDate: TimeInterval(bitPattern: forInterval))
    }
    
    // MARK: - Core Data stack
    
    private var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "InTouch")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

