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
    
    let data = (1...100).map { "Item \($0)" }
    
    @State private var showingAddTask = false
    @State private var selection: TabBarItem = .home
    
    @State var rows: [GridItem]
    
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
    }
    
    private func home() -> some View {
        NavigationStack {
            ScrollView(taskModel.savedTasks.isEmpty ? .init() : .vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(taskModel.savedTasks) { task in
                        NavigationLink {
                            TaskDetailView(task: task, taskModel: taskModel)
                        } label: {
                            HabitCardView(task: task)
                                .foregroundColor(.black)
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
            .navigationTitle("Habits")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct Previews_ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(taskModel: TaskViewModel())
//    }
//}
