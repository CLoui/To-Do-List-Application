//
//  ContentView.swift
//  CoreDataToDo
//
//  Created by Samantha So on 2020-08-12.
//  Copyright © 2020 Courtney Loui. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems:FetchedResults<ToDoItem>
    
    @State private var newToDoItem = ""
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("New Task")) {
                    HStack {
                        TextField("New Item", text: self.$newToDoItem)
    
                    }
                }.font(.headline)
                Section(header: Text("Date and Time")) {
                    HStack {
                        Text("Select a Date and Time:")
                    }
                    HStack {
                        DatePicker("", selection: self.$selectedDate, displayedComponents: [.date, .hourAndMinute])
                    }.padding()
                }
            }
            .navigationBarTitle(Text("New Task")) //, displayMode: .inline
                .navigationBarItems(leading: Button("Cancel", action: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                , trailing: Button(action: {
                    if !self.newToDoItem.isEmpty {
                        let toDoItem = ToDoItem(context: self.managedObjectContext)
                        toDoItem.title = self.newToDoItem
                        toDoItem.date = Date()
                        toDoItem.createdAt = self.selectedDate
                        toDoItem.completed = false
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                        
                        self.newToDoItem = ""
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Done")
                }
            )
            
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
