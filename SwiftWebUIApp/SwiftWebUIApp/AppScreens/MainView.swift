import SwiftWebUI
import Foundation

struct MainView: View {
  @State var title: String = ""
  @State var todos: [TodoModel] = .mock
  @State var isLoading: Bool = false
  
  var body: some View {
    List {
      HStack {
        TextField($title, placeholder: Text("todo item name"))
        Spacer()
        Button("+") {
          if title.isEmpty {
            return
          }
          todos.append(TodoModel(title: title, isCompleted: false))
          title = ""
        }
        .frame(width: 40, height: 40, alignment: .center)
      }
      
      if todos.isEmpty {
        Text("Empty")
          .foregroundColor(.darkGray)
      } else {
        List(todos) { todo in
          HStack {
            Text(todo.title)
            Spacer()
            Button("-") {
              todos.removeAll {
                $0.id == todo.id
              }
            }
            .frame(width: 40, height: 40, alignment: .center)
          }
        }
      }
    }
  }
}
