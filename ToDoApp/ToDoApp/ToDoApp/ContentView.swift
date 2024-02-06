//
//  ContentView.swift
//  ToDoApp
//
//  Created by Asad Sayeed on 05/02/24.
//

import SwiftUI

struct TaskItem: Identifiable {
    let id = UUID()
    let name: String
}

@Observable
class Tasks {
    var items = [TaskItem]()
    var isCompleted = true
}

struct ContentView: View {
    @State private var tasks = Tasks()
    @State private var name = ""
    
    var body: some View {
        NavigationStack{
            VStack 
            {
                List
                {
                    Section(header: Text("Tasks"))
                    {
                        ForEach(tasks.items)
                        { task in
                            HStack
                            {
                                Text(task.name)
                                    .opacity(tasks.isCompleted ? 50 : 100)
                                
                                Image(systemName: tasks.isCompleted ? "checkmark.square" : "square")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                                    .listRowInsets(EdgeInsets())
                                    .onTapGesture {
                                        tasks.isCompleted.toggle()
                                    }
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                HStack (spacing: 8) {
                    TextField("  New Task", text: $name)
                        .grayscale(tasks.isCompleted ? 1 : 0)
                        .border(Color.gray)
                        .opacity(0.5)
                        .padding()
                    
                    Spacer()
                    Button("Add") {
                        let item = TaskItem(name: name)
                        tasks.items.append(item)
                    }
                    .foregroundColor(.gray)
                }
                .padding()
            }
            .padding()
            .navigationTitle("📝 To-Do List App 📝")
            .frame(alignment: .topLeading)
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        tasks.items.remove(atOffsets: offsets)
    }
    
}

#Preview {
    ContentView()
}
