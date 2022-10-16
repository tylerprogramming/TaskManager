//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/16/22.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var taskModel: TaskViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Text("Add Task")
                .overlay {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("", text: $taskModel.taskTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
            }
            
            Divider()
            
            Button {
                taskModel.addTask()
                dismiss()
            } label: {
                Text("Save Task")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .foregroundColor(.white)
                    .background {
                        Capsule()
                            .fill(.green)
                    }
             }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
            .disabled(taskModel.taskTitle == "")
            .opacity(taskModel.taskTitle == "" ? 0.6 : 1.0)
        }
    }
}
