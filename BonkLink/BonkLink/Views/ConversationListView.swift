//
//  ConversationListView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/19/21.
//

import SwiftUI
import RealmSwift

struct ConversationListView: View {
    
    @EnvironmentObject var state: AppState
    @ObservedResults(Users.self) var users
    
    var isPreview = false
    
    @State private var conversation: Conversation?
    @State var showConversation = false
    @State var showingAddChat = false
    
    private let animationDuration = 0.5
    private let sortDescriptors = [
        SortDescriptor(keyPath: "unreadCount", ascending: false),
        SortDescriptor(keyPath: "displayName", ascending: true)
    ]
    
    var body: some View {
        VStack {
            if let conversations = users[0].conversations.sorted(by: sortDescriptors) {
                List {
                    ForEach(conversations) { conversation in
                        Button(action: {
                            self.conversation = conversation
                            showConversation.toggle()
                        }) { ConversationCardView() }
                    }
                }
                .animation(.easeIn(duration: animationDuration))
                Button(action: { showingAddChat.toggle() }) {
                    Text("New Chat Room")
                }
                .disabled(showingAddChat)
            }
            Spacer()
            if isPreview {
                NavigationLink(
                    destination: ChatRoomView(conversation: conversation),
                    isActive: $showConversation) { EmptyView() }
            } else {
                if let user = state.user {
                    NavigationLink(
                        destination: ChatRoomView(conversation: conversation)
                            .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(user._id)")),
                        isActive: $showConversation) { EmptyView() }
                }
            }
        }
        .sheet(isPresented: $showingAddChat) {
            NewConversationView()
                .environmentObject(state)
                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "all-users=all-the-users"))
        }
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
