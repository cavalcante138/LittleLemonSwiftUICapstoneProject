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
    @Environment(\.presentationMode) var presentation
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Dish.title, ascending: true)])
    private var dishes: FetchedResults<Dish>


    
    var body: some View {
        VStack {
          Header(
            isProfilePicturePresent: true)
            VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("Little Lemon")
                        .fontWeight(.bold)
                        .foregroundColor(Color("secondarycolor"))
                        .font(Font.custom("MarkaziText-Medium", size: 32, relativeTo: .title))
                    Text("Chicago")
                        .font(Font.custom("MarkaziText-Medium", size: 26, relativeTo: .subheadline))
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.caption)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 0))
                        .multilineTextAlignment(.leading)
                }
                Image("banner")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                // add border and corner radius
                .cornerRadius(20)

            }
            TextField("Search menu", text: $searchText)
                .padding()
                .background(Color.white)
                .foregroundColor(Color("LittleLemonPrimaryColor"))
                .cornerRadius(5.0)

            }  .padding()
                .background(Color("LittleLemonPrimaryColor"))
                .foregroundColor(Color.white)

        Group {
            HStack {
                Text("ORDER FOR DELIVERY")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }.padding(EdgeInsets(top: 24, leading: 12, bottom: 0, trailing: 0))
            ScrollView(.horizontal, showsIndicators: false){
            HStack {
            Button(action: {
                }) {
                    Text("All")
                        .font(.system(size: 16, weight: .bold))
                           .foregroundColor(Color("LittleLemonPrimaryColor"))
                           .frame(minWidth: 70)
                           .padding(
                            EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
                           )
                           .background(RoundedRectangle(cornerRadius: 8)
                                           .stroke(Color("LittleLemonPrimaryColor"), lineWidth: 1)
                                           .background(Color("grey")))
                          .scaleEffect(1.0)
                  }
                Spacer()
                            Button(action: {
                }) {
                    Text("Mains")
                        .font(.system(size: 16, weight: .bold))
                           .foregroundColor(Color("LittleLemonPrimaryColor"))
                           .frame(minWidth: 70)
                           .padding(
                            EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
                           )
                           .background(RoundedRectangle(cornerRadius: 8)
                                           .stroke(Color("LittleLemonPrimaryColor"), lineWidth: 1)
                                           .background(Color("grey")))
                          .scaleEffect(1.0)
                  }
                Spacer()
            Button(action: {
                }) {
                    Text("Desserts")
                        .font(.system(size: 16, weight: .bold))
                           .foregroundColor(Color("LittleLemonPrimaryColor"))
                           .frame(minWidth: 70)
                           .padding(
                            EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
                           )
                           .background(RoundedRectangle(cornerRadius: 8)
                                           .stroke(Color("LittleLemonPrimaryColor"), lineWidth: 1)
                                           .background(Color("grey")))
                          .scaleEffect(1.0)
                  }
                Spacer()
            Button(action: {
                }) {
                    Text("Drinks")
                        .font(.system(size: 16, weight: .bold))
                           .foregroundColor(Color("LittleLemonPrimaryColor"))
                           .frame(minWidth: 70)
                           .padding(
                            EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
                           )
                           .background(RoundedRectangle(cornerRadius: 8)
                                           .stroke(Color("LittleLemonPrimaryColor"), lineWidth: 1)
                                           .background(Color("grey")))
                          .scaleEffect(1.0)
                  }
            }.padding(EdgeInsets(top: 8, leading: 12, bottom: 0, trailing: 12))
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))     
        }   
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {                         
                            AsyncImage(url: URL(string: dish.image ?? "")!) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                     // image cover
                                        .aspectRatio(contentMode: .fill)
                                        .padding(
                                            EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                                        )
                                case .failure:
                                    Image(systemName: "xmark.octagon")
                                        .resizable()
                                        .scaledToFit()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 100, height: 100)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(dish.title ?? "")
                                Spacer()
                                // To implement optional description
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                .foregroundColor(Color.gray)
                                Spacer()
                                // price with two decimal places
                                Text("$" + (dish.price ?? ""))
                                .foregroundColor(Color.gray)
                            }
                        }
                        .padding()
                        // border width only on top and bottom
                        .border(Color("grey"), width: 1)
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
    // function to now the font name in the system
    // func nowthefont() -> Void{
    //     for familyName in UIFont.familyNames{
    //         print(familyName)
            
    //         for fontName in UIFont.fontNames(forFamilyName: familyName){
    //             print("-- \(fontName)")
    //         }
    //     }
    // }
    
}



struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

