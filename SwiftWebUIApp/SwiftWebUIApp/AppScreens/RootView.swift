import SwiftWebUI

struct RootView: View {
   
   var body: some View {
     TabView {
       LoginView()
         .tabItem(Text("Login"))
       RegisterView()
         .tabItem(Text("Regiser"))
       MainView()
         .tabItem(Text("Todos"))
     }
     .padding()
     .relativeWidth(0.95)
     .relativeHeight(0.95)
   }
}
