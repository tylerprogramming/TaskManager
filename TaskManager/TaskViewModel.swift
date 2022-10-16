//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/16/22.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var taskTitle: String = ""
    @Published var taskIsCompleted: Bool = false
    @Published var showDatePicker: Bool = false
    
    @Published var savedTasks: [Task] = []

    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TaskManager")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        
        fetchTasks()
    }
    
    func fetchTasks() {
        let request = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            savedTasks = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addTask() {
        var task: Task!

        task = Task(context: container.viewContext)
        
        task.title = taskTitle
        task.isComplete = false
        task.timestamp = Date.now
        
        saveTask()
    }
    
    func saveTask() {
        do {
            try container.viewContext.save()
            fetchTasks()
        } catch let error {
            print("Error saving new Task: \(error)")
        }
    }
    
    func deleteTask(task: Task) {
        container.viewContext.delete(task)
        saveTask()
    }
}
