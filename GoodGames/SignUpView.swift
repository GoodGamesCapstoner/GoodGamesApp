import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @State private var vm = signUpViewModel()
    var body: some View {
        ZStack {
            
            // Background
            Color(hex: "282828")
            
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                            .foregroundStyle(.linearGradient(colors: [.purple, .blue], startPoint:
                                    .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 1000, height: 400)
                            .rotationEffect(.degrees(135))
                            .offset(y: -350)
            
            // VStack for the login fields
            VStack(spacing: 20) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .font(.system(size:40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -100)
                
                // HStack holding the first and last name fields each with their own VStack to
                // match the formatting of the other fields. Notice that the rectangle is slightly
                // shorter for first name than last name to account for the gap between them
                HStack {
                    VStack(spacing: 20) {
                        TextField("", text: $vm.firstName)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: vm.firstName.isEmpty) {
                                Text("First Name")
                                    .foregroundColor(.white)
                                    .bold()
                                    .multilineTextAlignment(.center)
                            }
                        Rectangle()
                            .frame(width: 165, height: 1)
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 20) {
                        TextField("", text: $vm.lastName)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: vm.lastName.isEmpty) {
                                Text("Last Name")
                                    .foregroundColor(.white)
                                    .bold()
                                    .multilineTextAlignment(.center)
                            }
                        Rectangle()
                            .frame(width: 175, height: 1)
                            .foregroundColor(.white)
                    }
                }
                
                // Username, email, and password all within the parent VStack
                TextField("", text: $vm.username)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: vm.username.isEmpty) {
                        Text("Username")
                            .foregroundColor(.white)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                TextField("", text: $vm.email)
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
                
                SecureField("", text: $vm.password)
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
                
                // Group used to avoid max arguments (10) in the VStack
                // Most likely not necessary since adding in the HStack for first and last name
                // but this will help in case we add additional fields later
                Group {
                    // Creates a user when pressed if successful
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
                    
                    //Goes back to login
                    Button {
                        dismiss()
                    } label: {
                        Text("Back to Login")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                }
            }
            .frame(width: 350)
        }
        .ignoresSafeArea()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
