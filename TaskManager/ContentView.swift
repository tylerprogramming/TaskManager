//
//  ContentView.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/14/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var taskModel: TaskViewModel
    
    @State private var showingAddTask = false
    @State private var selection: TabBarItem = .home

    var body: some View {
        NavigationStack {
            CustomTabBarContainerView(selection: $selection) {
                home()
                    .tabBarItem(tab: .home, selection: $selection)
                AddTaskView(taskModel: taskModel, selectedTab: $selection)
                    .tabBarItem(tab: .favorites, selection: $selection)
                Color.green
                    .tabBarItem(tab: .profile, selection: $selection)
            }
        }
        .navigationDestination(for: Task.self) { task in
            TaskRow(task: task, taskModel: taskModel)
        }
    }
    
    private func home() -> some View {
        NavigationStack {
            List {
                ForEach(taskModel.savedTasks) { task in
                    NavigationLink(task.title ?? "", value: task)
                }
            }
            .navigationTitle("Tasks")
            .navigationDestination(for: Task.self) { task in
                TaskRow(task: task, taskModel: taskModel)
            }
        }
    }
}

struct TaskRow: View {
    let task: Task
    @ObservedObject var taskModel: TaskViewModel
    
    var body: some View {
        VStack {
            Text(task.title ?? "")
                .font(.title)
                .navigationTitle(task.title ?? "")
            
            Button {
                taskModel.deleteTask(task: task)
            } label: {
                Text("Delete?")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct Previews_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(taskModel: TaskViewModel())
    }
}
