//
//  ToDoList.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/16/26.
//

import SwiftUI
internal import CoreData


struct ToDoList: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
       //could put fetching code here
        NavigationView {
            List {
                ForEach(viewModel.items) {item in
                    Section(header: HStack{
                        Text(item.name ?? "--")
                        Spacer()
                        Button(action: {
                            viewModel.beginAddingTask(category: item)
                        }){
                            Label("", systemImage: "plus")
                        }
                    }) {
                        let tasks = (item.tasks?.allObjects as? [ToDoItem]) ?? []
                        ForEach(tasks) { task in
                            Text(task.name ?? "--") //check this
                        }
                        .onDelete(perform: {indexSet in
                            viewModel.deleteItems(offsets: indexSet, in: tasks)
                        })
                    }
                }
            }
            .id(viewModel.contentVersion)
            .toolbar{
                Button(action: {viewModel.beginAddingCategory()}) {
                    Label("Add Item", systemImage: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingAddSheet) {
                NavigationStack {
                    Form {
                        TextField("New Item Name", text: $viewModel.newItemText)
                    }
                
                .navigationTitle("Add Item")
                    
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            viewModel.showingAddSheet = false
                            viewModel.newItemText = ""
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            if !viewModel.newItemText.isEmpty {
                                viewModel.addItem()
                                viewModel.showingAddSheet = false
                                viewModel.newItemText = ""
                            }
                        }
                    }
                }
            }
                
            }
            .task {
                viewModel.loadData(viewContext: viewContext)
            }
        }
    }
    
    
}



extension ToDoList {
    
    @Observable
    class ViewModel: NSObject, NSFetchedResultsControllerDelegate {
        
        var items: [ToDoCategory] = []
        var showingAddSheet = false
        var newItemText = ""
        var selectCategory: ToDoCategory? = nil
        var contentVersion = 1
        
        
        private var resultsController: NSFetchedResultsController<ToDoCategory>? = nil
        private var viewContext: NSManagedObjectContext?
        
        func loadData(viewContext: NSManagedObjectContext){
            self.viewContext = viewContext
            guard items.isEmpty else {return}
            
            let request = ToDoCategory.fetchRequest()
            request.sortDescriptors = [
                NSSortDescriptor(keyPath: \ToDoCategory.name, ascending: false)
            ]
            
            resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
            )
            
            resultsController?.delegate = self
            
            do{
                try resultsController?.performFetch()
                items = resultsController?.fetchedObjects ?? []
            }
            catch{
                print("Failed to fetch to Do Items: ")
            }
            
            
        }
        
        //automatically update the published items when the core data changes
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
            if let updatedItems = controller.fetchedObjects as? [ToDoCategory] {
                items = updatedItems
                contentVersion += 1
            }
        }
        
        
        func beginAddingCategory() {
            showingAddSheet = true
            selectCategory = nil
        }
        
        func beginAddingTask(category: ToDoCategory) {
            selectCategory = category
            showingAddSheet = true
        }
        
         func addItem(){
             guard let viewContext else {return}
             
             withAnimation {
                 if let cat = selectCategory{
                     let newItem = ToDoItem(context: viewContext)
                     newItem.name = newItemText
                     newItem.dateAssigned = Date()
                     newItem.category = cat
                 } else {
                     
                     let newCat = ToDoCategory(context: viewContext)
                     newCat.name = newItemText
                 }
                 saveContext()
             }
        }
            
        private func saveContext () {
            guard let viewContext else {return}
            do {
                try viewContext.save()
            }
            catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            }
        
        func deleteItems(offsets: IndexSet, in tasks: [ToDoItem]) {
            guard let viewContext else {return}
            withAnimation {
                offsets.map {tasks[$0]}
                    .forEach(viewContext.delete)
                saveContext()
                contentVersion += 1
            }
        }
        
    }
}
