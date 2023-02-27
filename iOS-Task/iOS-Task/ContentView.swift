//
//  ContentView.swift
//  iOS-Task
//
//  Created by Kullanici on 26.02.2023.
//

import SwiftUI
import UIKit
struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State var searchText = ""
    
    var filteredDatas: [ArrayModel] {
        filterArrayModels(with: searchText, from: networkManager.datas)
        }
    var body: some View {
        NavigationView {
            
            List(filteredDatas) { data in
                VStack{
                HStack {
                    Text(data.task).background(Color.white)
                    Text(data.title).background(Color.white)
                }
                    Text(data.description).background(Color.white)
                }
                .listRowBackground(Color(hex: data.colorCode ?? "#FFFFFF"))
                
            }
            .navigationBarTitle("Vero Digital")
        }
        .onAppear {
            self.networkManager.fetchData()
            
        }
        .refreshable {
            self.networkManager.fetchData()
        }
        .searchable(text: $searchText)
    }
    func filterArrayModels(with keyword: String, from arrayModels: [ArrayModel]) -> [ArrayModel] {
        if keyword.isEmpty {
            return arrayModels
        }
        return arrayModels.filter { model in
            let mirror = Mirror(reflecting: model)
            for child in mirror.children {
                if let value = child.value as? String, value.lowercased().contains(keyword.lowercased()) {
                    return true
                }
            }
            return false
        }
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
