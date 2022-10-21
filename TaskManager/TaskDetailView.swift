//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/21/22.
//

import SwiftUI

struct TaskDetailView: View {
    var task: Task
    @ObservedObject var taskModel: TaskViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text(task.title ?? "")
                .font(.title)
                .navigationTitle(task.title ?? "")
            Text(task.desc ?? "")
                .font(.subheadline)
            
            Button {
                taskModel.deleteTask(task: task)
                dismiss()
            } label: {
                Text("Delete?")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
            }
            
            let calendar = Calendar.current
            let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: Date())
            let symbols = calendar.weekdaySymbols
            let startDate = currentWeek?.start ?? Date()
            let activeWeekDays = task.weekDays ?? []
            let activePlot = symbols.indices.compactMap({ index -> (String, Date) in
                let currentDate = calendar.date(byAdding: .day, value: index, to: startDate)
                return (symbols[index], currentDate!)
            })
            
            HStack {
                ForEach(activePlot.indices, id: \.self) { index in
                    let item = activePlot[index]
                    
                    VStack(spacing: 6) {
                        Text(item.0.prefix(3))
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        let status = activeWeekDays.contains { day in
                            return day == item.0
                        }
                        
                        Text(getDate(date: item.1))
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .padding(8)
                            .background {
                                Circle()
                                    .fill(.green)
                                    .opacity(status ? 1 : 0)
                            }
                        
                    }
                    
                }
            }
        }
    }
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
}
