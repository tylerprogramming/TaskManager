//
//  EditTaskView.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/14/22.
//

import SwiftUI

struct EditTaskView: View {
    @State var task: Task
    
    var body: some View {
        Text("The Task: \(task.title ?? "") - \(task.timestamp!)")
    }
}
