//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/16/22.
//

import SwiftUI
import CoreData
import UserNotifications

class TaskViewModel: ObservableObject {
    @Published var taskTitle: String = ""
    @Published var taskDescription: String = ""
    @Published var taskIsCompleted: Bool = false
    @Published var showDatePicker: Bool = false
    @Published var weekDays: [String] = []
    @Published var frequency: Int = 0
    @Published var reminderTime = Date()
    @Published var hasReminder = false
    @Published var notificationIDs = []
    @Published var habitColor = "green"
    
    @Published var savedTasks: [Task] = []
    
    @Published var notificationAccess: Bool = false
    
    

    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TaskManager")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        
        requestNotificationAccess()
        fetchTasks()
    }
    
    func requestNotificationAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { status, _ in
            DispatchQueue.main.sync {
                self.notificationAccess = status
            }
        }
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
        task.desc = taskDescription
        task.weekDays = weekDays
        task.frequency = Int32(frequency)
        task.isComplete = false
        task.reminderTime = reminderTime
        task.timestamp = Date.now
        task.hasReminder = hasReminder
        task.color = habitColor
        
        if hasReminder {
            if let ids = try? scheduleNotification(){
                task.notificationIDs = ids
            }
            
            saveTask()
        } else {
            saveTask()
        }
    }
    
    func saveTask() {
        do {
            try container.viewContext.save()
            fetchTasks()
            resetData()
        } catch let error {
            print("Error saving new Task: \(error)")
        }
    }
    
    func deleteTask(task: Task) {
        container.viewContext.delete(task)
        saveTask()
    }
    
    func scheduleNotification() -> [String] {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.subtitle = taskTitle
        content.sound = UNNotificationSound.default
        
        var notificationIDs: [String] = []
        let calendar = Calendar.current
        let weekDaySymbols: [String] = calendar.weekdaySymbols
        
        // MARK: Scheudling Notification
        for weekDay in weekDays {
            let id = UUID().uuidString
            let hour = calendar.component(.hour, from: reminderTime)
            let min = calendar.component(.minute, from: reminderTime)
            let day = weekDaySymbols.firstIndex { currentDay in
                return currentDay == weekDay
            } ?? -1
            
            if day != -1 {
                // day of week starts from 1-7, so need to add 1 since array starts at zero
                var components = DateComponents()
                components.hour = hour
                components.minute = min
                components.weekday = day + 1
                
                // this will trigger notification
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                
                // MARK: Notification Request
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
                
                notificationIDs.append(id)
            }
        }
        
        return notificationIDs
    }
    
    func resetData() {
        taskTitle = ""
        taskDescription = ""
        weekDays = []
        frequency = 0
        reminderTime = Date()
        hasReminder = false
        habitColor = "green"
    }
}
