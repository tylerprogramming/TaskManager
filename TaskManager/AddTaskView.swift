//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/16/22.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var taskModel: TaskViewModel
    @Binding var selectedTab: TabBarItem
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Task Information")) {
                    TextField("Task Title", text: $taskModel.taskTitle)
                }
            }
            
            Button {
                withAnimation(.easeInOut) {
                    taskModel.addTask()
                    selectedTab = .home
                }
            } label: {
                Text("Save Task")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
             }
            .padding(20)
            .background {
                Capsule()
                    .fill(.green)
                    .shadow(color: .black, radius: 5, x: 0, y: 5)
            }
            
            .disabled(taskModel.taskTitle == "")
            .opacity(taskModel.taskTitle == "" ? 0.6 : 1.0)
        }
    }
}
