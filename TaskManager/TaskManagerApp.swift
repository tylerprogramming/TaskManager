//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/14/22.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    @StateObject var taskModel = TaskViewModel()

    var items: [GridItem] = []
    
    var body: some Scene {
        WindowGroup {
            ContentView(taskModel: taskModel, rows: items)
        }
    }
}
