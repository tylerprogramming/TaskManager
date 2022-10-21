//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/16/22.
//

import SwiftUI
import CoreData

struct AddTaskView: View {
    @ObservedObject var taskModel: TaskViewModel
    @Binding var selectedTab: TabBarItem
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Task Title", text: $taskModel.taskTitle)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color("CardColor").opacity(0.4), in:
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                )
            
            TextField("Task Description (Optional)", text: $taskModel.taskDescription)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color("CardColor").opacity(0.4), in:
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                )
            
            
            HStack(spacing: 0) {
                ForEach(1...7, id: \.self) { index in
                    let color = "Card-\(index)"
                    Circle()
                        .fill(Color(color))
                        .frame(width: 30, height: 30)
                        .overlay {
                            if color == taskModel.habitColor {
                                Image(systemName: "checkmark")
                                    .font(.caption.bold())
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                taskModel.habitColor = color
                            }
                        }
                        .frame(maxWidth: .infinity)
                }
            }
            
            Divider()
                .padding(.vertical, 10)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Days")
                    .font(.callout.bold())
                let weekDays = Calendar.current.weekdaySymbols
                
                HStack(spacing: 10) {
                    ForEach(weekDays, id: \.self) { day in
                        let index = taskModel.weekDays.firstIndex { value in
                            return value == day
                        } ?? -1
                        Text(day.prefix(2))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(index != -1 ? Color(taskModel.habitColor) : .gray.opacity(0.4))
                            }
                            .onTapGesture {
                                withAnimation {
                                    if index != -1 {
                                        taskModel.weekDays.remove(at: index)
                                    } else {
                                        taskModel.weekDays.append(day)
                                    }
                                }
                            }
                    }
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Per Day:")
                        .fontWeight(.semibold)
                    
                    TextField("", value: $taskModel.frequency, formatter: NumberFormatter())
                    Stepper("", value: $taskModel.frequency, in: 0...100)
                }
                
                Divider()
                    .padding(.vertical, 10)
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Reminder")
                            .fontWeight(.semibold)
                        
                        Text("Need Notified?")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DatePicker("", selection: $taskModel.reminderTime, displayedComponents: [.hourAndMinute])
                    
                    Spacer()
                    
                    Toggle(isOn: $taskModel.hasReminder) {
                        Text("")
                    }
                }
                .opacity(taskModel.notificationAccess ? 1 : 0)
                
                Spacer()
                
                HStack {
                    Button {
                        taskModel.addTask()
                        
                        withAnimation {
                            selectedTab = .home
                        }
                    } label: {
                        Text("Save")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 75, height: 75)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background {
                        Circle()
                            .fill(.green)
                            .shadow(color: .black, radius: 2, x: 0, y: 3)
                    }
                    .disabled(taskModel.taskTitle == "")
                    .opacity(taskModel.taskTitle == "" ? 0.4 : 1.0)
                }
                .padding(.vertical, 10)
                
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        
                
    }
}
