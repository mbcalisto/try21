import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Drawing.entity(), sortDescriptors: []) var drawings: FetchedResults<Drawing>
    
    @State private var showSheet = false
//    @State private var isLocked = true
//    @State var buttonTapped = false
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(drawings){drawing in
                        NavigationLink(destination: DrawingView(id: drawing.id, data: drawing.canvasData, title: drawing.title), label: {
                            Text(drawing.title ?? "Untiled")
                        })
                    }
                    .onDelete(perform: deleteItem)
                }
                .listStyle(.insetGrouped)
                .navigationTitle(Text("Try21"))
//                EditButton()
                Button(action: {
                    self.showSheet.toggle()
//                    self.buttonTapped.toggle()
//                    self.isLocked.toggle()
                }, label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add a day")
                    }
                })
//                .disabled(buttonTapped)
//                .opacity(isLocked ? 1.0 : 0.0)
                .foregroundColor(.blue)
                .sheet(isPresented: $showSheet, content: {
                    AddNewCanvasView().environment(\.managedObjectContext, viewContext)
                })
            }
            VStack{
                Image(systemName: "scribble.variable")
                    .font(.largeTitle)
                Text("No canvas has been selected")
                    .font(.title)
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
    
    func deleteItem(at offset: IndexSet) {
        for index in offset{
            let itemToDelete = drawings[index]
            viewContext.delete(itemToDelete)
            do{
                try viewContext.save()
            }
            catch{
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
