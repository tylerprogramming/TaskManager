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

    var body: some Scene {
        WindowGroup {
            ContentView(taskModel: taskModel)
        }
    }
}
