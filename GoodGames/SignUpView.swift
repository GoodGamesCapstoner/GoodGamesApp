import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @State private var vm = signUpViewModel()
    var body: some View {
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                            .foregroundStyle(.linearGradient(colors: [.purple, .blue], startPoint:
                                    .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 1000, height: 400)
                            .rotationEffect(.degrees(135))
                            .offset(y: -350)
            
            VStack(spacing: 20) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .font(.system(size:40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -100)
                
                TextField("Full Name", text: $vm.fullname)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: vm.fullname.isEmpty) {
                        Text("Full Name")
                            .foregroundColor(.white)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                TextField("Email Address", text: $vm.email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: vm.email.isEmpty) {
                        Text("Email Address")
                            .foregroundColor(.white)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $vm.password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: vm.password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.white)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button {
                    vm.createUser { success in
                        if success {
                            dismiss()
                        }
                    }
                } label: {
                    Text("Create Account")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        .foregroundColor(.white)
                }
                .foregroundColor(.white)
                
                //Button to go back to login
                Button {
                    dismiss()
                } label: {
                    Text("Back to Login")
                        .bold()
                        .foregroundColor(.white)
                }
                .buttonStyle(.bordered)
            }
            .frame(width: 350)
//            .padding()
//            .textFieldStyle(.roundedBorder)
//        .autocapitalization(.none)
        }
        .ignoresSafeArea()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
