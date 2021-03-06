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
    
    func shiftNormalValue(val: Int) -> Int{
        let pert = Int(arc4random_uniform(5)) - 2
        return val + pert
    }
    
    func deleteAll() {
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Mood")
        var batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(batchDeleteRequest)
        } catch {
            // Error Handling
        }
        
         fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Diet")
         batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(batchDeleteRequest)
        } catch {
            // Error Handling
        }
        
         fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sleep")
         batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(batchDeleteRequest)
        } catch {
            // Error Handling
        }
        
         fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Mind")
         batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(batchDeleteRequest)
        } catch {
            // Error Handling
        }
        
        saveContext()
    }
    
    func populateData() {
        // DELETE ALL FIRST
        
        deleteAll()
        
        for i in 1...27 {
            let randHour = 1+Int(arc4random_uniform(9))
            // Normalize between 1-7
            let randNorm = (Int)(((Double)(randHour))/9.0 * 2.9 + 3)
          //  print(randNorm)
            var dateComp = DateComponents()
            dateComp.year = 2018
            dateComp.month = 1
            dateComp.day = i
            let calendar = Calendar(identifier: .gregorian)
            
            // Mind
            let mind = Mind.init(
                entity: NSEntityDescription.entity(forEntityName: "Mind", in: persistentContainer.viewContext)!,
                insertInto: persistentContainer.viewContext)
            mind.date = calendar.date(from: dateComp)
            mind.length = (Double)(Int64(shiftNormalValue(val: randNorm)))/7.0 * 1800.0
            
            // Sleep
            let sleep = Sleep.init(
                entity: NSEntityDescription.entity(forEntityName: "Sleep", in: persistentContainer.viewContext)!,
                insertInto: persistentContainer.viewContext)
            sleep.date = calendar.date(from: dateComp)
            sleep.hoursOfSleep = Int64(randHour)
            
            // Mood
            let mood = Mood.init(
                entity: NSEntityDescription.entity(forEntityName: "Mood", in: persistentContainer.viewContext)!,
                insertInto: persistentContainer.viewContext)
            mood.date = calendar.date(from: dateComp)
            mood.moodVal = Int64(shiftNormalValue(val: randNorm))
            
            // Diet
            let diet = Diet.init(
                entity: NSEntityDescription.entity(forEntityName: "Diet", in: persistentContainer.viewContext)!,
                insertInto: persistentContainer.viewContext)
            diet.date = calendar.date(from: dateComp)
            
            diet.caffeine = 8 - Int64(shiftNormalValue(val: randNorm))
            diet.hydartion = Int64(shiftNormalValue(val: randNorm))
            diet.junk = 8 - Int64(shiftNormalValue(val: randNorm))
            diet.veggies = Int64(shiftNormalValue(val: randNorm))
            
            saveContext()
            
        }
    }
    
    // Mind
    
    func addMindData(length: Double) {
        let mind = Mind.init(
            entity: NSEntityDescription.entity(forEntityName: "Mind", in: persistentContainer.viewContext)!,
            insertInto: persistentContainer.viewContext)
        mind.date = getCurrentDate()
        mind.length = length
        saveContext()
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
        let sleep = Sleep.init(
            entity: NSEntityDescription.entity(forEntityName: "Sleep", in: persistentContainer.viewContext)!,
            insertInto: persistentContainer.viewContext)
        sleep.date = getCurrentDate()
        sleep.hoursOfSleep = hours
        saveContext()
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
        let mood = Mood.init(
            entity: NSEntityDescription.entity(forEntityName: "Mood", in: persistentContainer.viewContext)!,
            insertInto: persistentContainer.viewContext)
        mood.date = getCurrentDate()
        mood.moodVal = moodVal
        saveContext()
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
        let goal = Goal.init(
            entity: NSEntityDescription.entity(forEntityName: "Goal", in: persistentContainer.viewContext)!,
            insertInto: persistentContainer.viewContext)
        goal.date = getCurrentDate()
        goal.text = goalText
        saveContext()
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
        let diet = Diet.init(
            entity: NSEntityDescription.entity(forEntityName: "Diet", in: persistentContainer.viewContext)!,
            insertInto: persistentContainer.viewContext)
        diet.date = getCurrentDate()
        
        diet.caffeine = caffeine
        diet.hydartion = hydration
        diet.junk = junk
        diet.veggies = veggies
            
        saveContext()
    }
    
    func getDietData(interval: graphInterval) -> [Diet] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Diet")
        let predicate = getBoundedPredicateFromInterval(interval: interval)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as! [Diet]
        } catch {
            return []
        }
    }
    
    // Diary
    
    func addDiaryData(diaryText: String) {
        let diary = Diary.init(
            entity: NSEntityDescription.entity(forEntityName: "Diary", in: persistentContainer.viewContext)!,
            insertInto: persistentContainer.viewContext)
        diary.date = getCurrentDate()
        diary.message = diaryText
        saveContext()
    }
    
    func getDiaryData() -> [Diary] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Diary")
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as! [Diary]
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
        
        return NSPredicate(format: "date >= %@", timeBound as NSDate)
    }
    
    private func getCurrentDate() -> Date {
        return Date()
    }
    
//    private func decodeDate(forInterval: UInt64) -> Date {
//        return Date(timeIntervalSinceReferenceDate: TimeInterval(bitPattern: forInterval))
//    }
    
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer = {
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
   
    func deleteEntity(entity: NSManagedObject) {
        persistentContainer.viewContext.delete(entity)
        saveContext()
    }
    
    func saveContext() {
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

