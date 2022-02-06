import protocol SwiftWebUI.Identifiable

struct TodoModel: Codable, Identifiable, Equatable {
  var id: String = String.random
  var title: String
  var isCompleted: Bool
}

extension Array where Element == TodoModel {
  
  static let mock: Self = [
    TodoModel(title: "AAA", isCompleted: true),
    TodoModel(title: "BBB", isCompleted: false),
    TodoModel(title: "CCC", isCompleted: true),
  ]
  
}
