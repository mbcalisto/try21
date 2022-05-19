import SwiftUI

struct AddNewCanvasView: View {
    
    @Environment (\.managedObjectContext) var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    @State private var canvasTitle = ""
 
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Canvas Title", text: $canvasTitle)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle(Text("Instructions"))
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
            })
            )
        }
        Button(action: {
            if !canvasTitle.isEmpty{
    
                let drawing = Drawing(context: viewContext)
                drawing.title = canvasTitle
                drawing.id = UUID()
                
                do {
                    try viewContext.save()
                }
                catch{
                    print(error)
                }
                
                self.presentationMode.wrappedValue.dismiss()
            }
        }, label: {
            
            Text("I'm READY!")
        })
    }
}

struct AddNewCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCanvasView()
    }
}
