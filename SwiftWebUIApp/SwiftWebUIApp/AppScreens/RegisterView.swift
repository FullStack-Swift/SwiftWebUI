import SwiftWebUI

struct RegisterView: View {
  @State var email: String = ""
  @State var password: String = ""
  
  var body: some View {
    Form {
      Section(header: Text("Register")) {
        TextField($email, placeholder: Text("Email"))
        SecureField($password, placeholder: Text("password"))
      }
      Section {
        Button("Register") {
          print("Login")
        }
      }
    }
  }
}
