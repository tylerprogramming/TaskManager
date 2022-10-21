//
//  CustomTabBarView.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/18/22.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    
    @Binding var selection: TabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .background(Color.black.ignoresSafeArea(edges: .bottom))
        .clipShape(
            Capsule()
        )
        .padding(.vertical, 5)
        .padding(.horizontal, 50)
    }
    
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.title)

        }
        .foregroundColor(selection == tab ? tab.color : .white)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
}
