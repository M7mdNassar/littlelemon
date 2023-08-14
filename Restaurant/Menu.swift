//
//  Menu.swift
//  Restaurant
//
//  Created by Mac on 13/08/2023.
//

import SwiftUI
import CoreData
struct Menu: View {
    
    func buildSortDescriptors() -> [NSSortDescriptor]{
        
        
        
        return  [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var menuItems: [MenuItem] = [] // Your MenuItem model

    var body: some View {
        VStack {
                   Text("Awtar Restaurant")
                       .font(.largeTitle)
                       .padding()
                   
                   Text("Location: Chicago")
                       .font(.title)
                       .padding()
                   
                   Text("Welcome to Awtar Restaurant App! This app allows you to explore our delicious menu and place orders for your favorite dishes.")
                       .multilineTextAlignment(.center)
                       .padding()
                   
     
            FetchedObjects(fetchRequest: Dish.fetchRequest()) { dishes: FetchedResults<Dish> in
                           List(dishes) { dish in
                               HStack {
                                   Text("\(dish.title ?? "") - $\(dish.price)")
                                   AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                       switch phase {
                                       case .empty:
                                           ProgressView()
                                       case .success(let image):
                                           image
                                               .resizable()
                                               .scaledToFit()
                                               .frame(width: 50, height: 50) // Adjust the size as needed
                                       case .failure:
                                           Image(systemName: "photo")
                                       @unknown default:
                                           EmptyView()
                                       }
                                   }
                                   .frame(width: 50, height: 50) // Set frame size for consistency
                               }
            
                   .onAppear {
                              getMenuData() // Call the getMenuData method on appear
                          }
               }
        
    }
    
    
    func getMenuData() {
            PersistenceController.shared.clear() // Clear the database
            
            let serverURLString = "https://your-api-url.com/menu"
            
            guard let url = URL(string: serverURLString) else {
                print("Invalid URL")
                return
            }

            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(MenuList.self, from: data) {
                        // Convert and save the menu items as Dish objects
                        for menuItem in decodedResponse.menu {
                            let dish = Dish(context: viewContext)
                            dish.title = menuItem.title
                            dish.image = menuItem.image
                            dish.price = menuItem.price
                        }

                        // Save the context to the database
                        do {
                            try viewContext.save()
                        } catch {
                            print("Error saving context: \(error)")
                        }
                    }

                }
            }
            
            task.resume() // Start the task
        }
    
    
            
            
            
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
