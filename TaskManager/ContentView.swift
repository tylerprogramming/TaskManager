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

    var body: some View {
        NavigationView {
            List {
                ForEach(taskModel.savedTasks) { task in
                    HStack {
                        Text(task.timestamp ?? Date.now, formatter: itemFormatter)
                        
                        Spacer()
                        
                        Button {
                            task.isComplete.toggle()
                        } label: {
                            Image(systemName: task.isComplete ? "circle" : "circle.inset.filled")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button("Add") {
                        showingAddTask.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(taskModel: taskModel)
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
