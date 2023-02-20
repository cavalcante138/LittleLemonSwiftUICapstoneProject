//
//  Menu.swift
//  LittleLemonSwiftUICapstoneProject
//
//  Created by Lucas Cavalcante on 19/02/23.
//

import CoreData
import SwiftUI


struct Menu: View {
    
    @State var menuItems: [MenuItem] = []
    @State private var searchText: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Dish.title, ascending: true)])
    private var dishes: FetchedResults<Dish>
    
    var body: some View {
        VStack {
               Text("Little Lemon")
                   .font(.title)
                   .fontWeight(.bold)
               Text("Chicago")
                   .font(.subheadline)
                   .foregroundColor(.gray)
               Text("Little Lemon offers a wide variety of delicious and healthy food options that are made fresh each day. You can browse the menu by category to find your favorites, and we offer a seamless ordering experience through the app.")
                   .font(.body)
                   .multilineTextAlignment(.center)
                   .padding()
                TextField("Search menu", text: $searchText)
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            HStack{
                                Text(dish.title ?? "")
                                Spacer()
                                Text(dish.price ?? "")
                            }
                            AsyncImage(url: URL(string: dish.image ?? "")!) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFit()
                                case .failure:
                                    Image(systemName: "xmark.octagon")
                                        .resizable()
                                        .scaledToFit()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 40, height: 40)
                        }
                    }
                    
                }
            }
           }.onAppear {
               getMenuData()
           }
    }
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: No data found")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let menu = try decoder.decode(MenuList.self, from: data)
                
                let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
                     let count = try viewContext.count(for: fetchRequest)
                     guard count == 0 else { return }
                
                PersistenceController.shared.clear()
                
                for item in menu.menu {
                    let dish = Dish(context: viewContext)
                    dish.title = item.title
                    dish.image = item.image
                    dish.price = item.price
                    dish.category = item.category
                }
                
                try? viewContext.save()
                
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
}



struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

