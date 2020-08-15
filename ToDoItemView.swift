//
//  ToDoItemView.swift
//  CoreDataToDo
//
//  Created by Samantha So on 2020-08-12.
//  Copyright © 2020 Courtney Loui. All rights reserved.
//

import SwiftUI

// createdAt(selected time) changed to date(time task is created at)
struct ToDoItemView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var title:String = ""
    var createdAt:String = ""
    
    var body: some View {
        HStack {
            VStack { Text(title).font(.headline) }
            VStack(alignment: .trailing) { Text(createdAt).font(.caption) }
        }// .frame(maxWidth: .infinity)
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        ToDoItemView(title: "To Do", createdAt: "Today") // isChecked: true,
    }
}
