import TokamakDOM
import Foundation
import ComposableArchitecture

struct TokamakApp: App {
  var body: some Scene {
    WindowGroup("TodoList App") {
      RootView()
    }
  }
}

struct RootView: View {
  var body: some View {
    ZStack {
      VStack(alignment: .center) {
        Text("TodoList App")
        CounterView(viewStore: ViewStore(Store(initialState: CounterState(), reducer: CounterReducer, environment: CounterEnvironment())))
        ComposableArchitectureMainView()
        MainView()
      }
    }
  }
}

struct CounterState: Equatable {
  var count: Int = 0
}

enum CounterAction: Equatable {
  case viewOnAppear
  case viewOnDisappear
  case none
  case increment
  case decrement
}

struct CounterEnvironment {
  
}

let CounterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, environment in
  switch action {
  case .increment:
    state.count += 1
  case .decrement:
    state.count -= 1
  default:
    break
  }
  return .none
}

struct CounterView: View {
  
  @ObservedObject
  var viewStore: ViewStore<CounterState, CounterAction>
  
  var body: some View {
    ZStack {
      HStack {
        Button {
          viewStore.send(.increment)
        } label: {
          Text("+")
        }
        Text("\(viewStore.count)")
        Button {
          viewStore.send(.decrement)
        } label: {
          Text("-")
        }
      }
    }
    .onAppear {
      viewStore.send(.viewOnAppear)
    }
    .onDisappear {
      viewStore.send(.viewOnDisappear)
    }
  }
}

struct TodoModel: Codable, Identifiable, Equatable {
  var id: UUID
  var title: String
  var isCompleted: Bool
}

extension Array where Element == TodoModel {
  static let mock: Self = [
    TodoModel(id: UUID(), title: "AAA", isCompleted: true),
    TodoModel(id: UUID(), title: "BBB", isCompleted: false),
    TodoModel(id: UUID(), title: "CCC", isCompleted: true),
  ]
}

struct MainState: Equatable {
  var todos: [TodoModel] = .mock
  var title: String = ""
}

enum MainAction: Equatable {
  case viewOnAppear
  case viewOnDisappear
  case none
  case changeText(String)
  case readTodo
  case createTodo
  case deleteTodo(TodoModel)
  case updateTodo(TodoModel)
}

struct MainEnvironment: Equatable {
  
}

let MainReducer = Reducer<MainState, MainAction, MainEnvironment> { state, action, environment in
  switch action {
  case .changeText(let value):
    state.title = value
  case .readTodo:
    print(action)
  case .createTodo:
    let todo = TodoModel(id: UUID(), title: state.title, isCompleted: false)
    state.todos.append(todo)
    state.title = ""
  case .updateTodo(let todo):
    if let index = state.todos.firstIndex(where: { item in
      item.id == todo.id
    }) {
      state.todos[index] = todo
    }
  case .deleteTodo(let todo):
    state.todos.removeAll {
      $0.id == todo.id
    }
  default:
    break
  }
  return .none
}

struct ComposableArchitectureMainView: View {
  
  private let store: Store<MainState, MainAction>
  
    //  @ObservedObject
  private var viewStore: ViewStore<MainState, MainAction>
  
  init(store: Store<MainState, MainAction>? = nil) {
    let unwrapStore = store ?? Store(initialState: MainState(), reducer: MainReducer, environment: MainEnvironment())
    self.store = unwrapStore
    self.viewStore = ViewStore(unwrapStore)
  }
  
  var body: some View {
    VStack {
      HStack {
        TextField("todo item name", text: viewStore.binding(get: \.title, send: MainAction.changeText))
        Button("+") {
          viewStore.send(.createTodo)
        }
      }
      Group {
        ForEach(viewStore.todos) { todo in
          HStack {
            Text(todo.title)
            Spacer()
            Button("-") {
              viewStore.send(.deleteTodo(todo))
            }
          }
        }
      }
    }
    .onAppear {
      viewStore.send(.viewOnAppear)
    }
    .onDisappear {
      viewStore.send(.viewOnDisappear)
    }
  }
}

struct MainView: View {
  @State var title: String = ""
  @State var todos: [TodoModel] = .mock
  @State var isLoading: Bool = false
  
  var body: some View {
    HStack {
      TextField("todo item name", text: $title)
      Button("+") {
        todos.append(TodoModel(id: UUID(), title: title, isCompleted: false))
        title = ""
      }
    }
    Group {
      ForEach(todos) { todo in
        HStack {
          Text(todo.title)
          Spacer()
          Button("-") {
            todos.removeAll {
              $0.id == todo.id
            }
          }
        }
      }
    }
  }
}

  // @main attribute is not supported in SwiftPM apps.
  // See https://bugs.swift.org/browse/SR-12683 for more details.
TokamakApp.main()
