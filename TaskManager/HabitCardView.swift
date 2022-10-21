//
//  HabitCardView.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/20/22.
//

import SwiftUI

struct HabitCardView: View {
    let task: Task
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Text(task.title ?? "")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Image(systemName: "bell.badge.fill")
                    .font(.callout)
                    .foregroundColor(Color(task.color ?? "green"))
                    .scaleEffect(0.9)
                    .opacity(task.hasReminder ? 1 : 0)
                
                Spacer()
                
                let count = task.weekDays?.count ?? 0
                Text(count == 7 ? "Everyday" : "\(count) times a week")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 10)
            
            HStack {
                Text(task.desc ?? "")
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            
            let calendar = Calendar.current
            let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: Date())
            let symbols = calendar.weekdaySymbols
            let startDate = currentWeek?.start ?? Date()
            let activeWeekDays = task.weekDays ?? []
            let activePlot = symbols.indices.compactMap({ index -> (String, Date) in
                let currentDate = calendar.date(byAdding: .day, value: index, to: startDate)
                return (symbols[index], currentDate!)
            })
            
            HStack(spacing: 0) {
                ForEach(activePlot.indices, id: \.self) { index in
                    let item = activePlot[index]
                    
                    VStack(spacing: 6) {
                        Text(item.0.prefix(3))
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        let status = activeWeekDays.contains { day in
                            return day == item.0
                        }
                        
                        Text(getDate(date: item.1))
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(8)
                            .background {
                                Circle()
                                    .fill(Color(task.color ?? "green"))
                                    .opacity(status ? 1 : 0)
                            }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
            }
            .padding(.top, 5)
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.vertical)
        .padding(.horizontal, 6)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color("CardColor"))
        }
    }
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
}
