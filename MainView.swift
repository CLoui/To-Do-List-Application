//
//  MainView.swift
//  CoreDataToDo
//
//  Created by Samantha So on 2020-08-13.
//  Copyright © 2020 Courtney Loui. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems:FetchedResults<ToDoItem>
    
    @State private var newToDoItem = ""
    @State var isChecked:Bool = false
    @State var alert:Bool = false
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        
        return dateFormatter
    }()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("To Do's")) {
                    ForEach(self.toDoItems) { toDoItem in
                        HStack {
                            VStack (alignment: .leading) {
                                Image(systemName: Bool(truncating: toDoItem.completed ?? false) ? "checkmark.circle.fill" : "circle").foregroundColor(.blue)
                                .onTapGesture {
                                    self.isChecked = Bool(truncating: toDoItem.completed ?? false)
                                    self.isChecked = !self.isChecked
                                    toDoItem.completed = NSNumber(value: self.isChecked)
                                    if Bool(truncating: toDoItem.completed ?? false) {
                                        self.alert = true;
                                    }
                                }.alert(isPresented: self.$alert) {
                                    Alert(title: Text("Delete?"),
                                        message: Text("Do you want to delete task?"),
                                        primaryButton: .default(Text("Ok")) {
                                            let deleteItem = toDoItem
                                            self.managedObjectContext.delete(deleteItem)
                                                
                                            do {
                                                try self.managedObjectContext.save()
                                            } catch {
                                                print (error)
                                            }
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                            }
                            VStack {
                                NavigationLink(destination: TaskView(title: toDoItem.title!, createdAt: Self.dateFormatter.string(from: toDoItem.createdAt!), completed: Bool(truncating: toDoItem.completed!))
                                    .navigationBarTitle(toDoItem.title!)) {
//                                    .navigationBarHidden(true)) {
                                    ToDoItemView(title: toDoItem.title!, createdAt: Self.dateFormatter.string(from:
                                        toDoItem.createdAt!))
                                }
                            }//, isChecked: Bool(truncating: toDoItem.completed!)
                            
                        }
                    }.onDelete {indexSet in
                        let deleteItem = self.toDoItems[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print (error)
                        }
                    }
                }
                                    
            }
            .navigationBarTitle(Text("To Do List")) //, displayMode: .inline
            .navigationBarItems(leading: NavigationLink(destination: ContentView()
                .navigationBarTitle("")
                .navigationBarHidden(true)) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
                    .imageScale(.large)
                }, trailing: EditButton())
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
