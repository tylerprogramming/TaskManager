//
//  CustomTabBarContainerView.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/18/22.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    
    @State private var tabs: [TabBarItem] = [.home, .favorites, .profile]
    @Binding var selection: TabBarItem
    let content: Content
    
    public init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}
