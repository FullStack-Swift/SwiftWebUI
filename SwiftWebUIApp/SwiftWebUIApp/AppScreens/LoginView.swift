import SwiftWebUI

struct LoginView: View {
  @State var email: String = ""
  @State var password: String = ""
  
  var body: some View {
    Form {
      Section(header: Text("Login")) {
        TextField($email, placeholder: Text("Email"))
        SecureField($password, placeholder: Text("password"))
      }
      
      Section {
        Button("Login") {
          print("Login")
        }
      }
    }
  }
}
