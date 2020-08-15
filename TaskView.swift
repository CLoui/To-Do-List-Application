//
//  TaskView.swift
//  CoreDataToDo
//
//  Created by Samantha So on 2020-08-14.
//  Copyright © 2020 Courtney Loui. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems:FetchedResults<ToDoItem>
    
    var title:String = ""
    var createdAt:String = ""
    var completed:Bool = false
//    @State private var title = ""
//    @State private var createdAt = Date()
    
    var body: some View {
//        NavigationView {
            List {
                Section(header: Text("Task")) {
                    HStack {
                        VStack { Text(title).font(.headline) }
                    }
                }.font(.headline)
                Section(header: Text("Date and Time")) {
                    HStack {
                        VStack { Text(createdAt).font(.headline) }
                    }
                }
                Section(header: Text("Completed")) {
                    HStack {
                        VStack { Text(completed ? "Complete" : "Incomplete").font(.headline)}
                    }
                }
            }
//        }.navigationBarItems(
//            trailing: Button(action: {
//                print("Done")
//            }) {
//                Text("Done")
//            }
                /*
                 leading: Button("Cancel", action: {
                     self.presentationMode.wrappedValue.dismiss()
                 })
                 */
//        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(title: "To Do", createdAt: "Today", completed: false)
    }
}
