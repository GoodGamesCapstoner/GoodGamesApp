import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @State private var vm = signUpViewModel()
    var body: some View {
        ZStack {
            
            // Background
            Color.primaryBackground
            
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                .foregroundColor(.secondaryBackground)
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            // VStack for the login fields
            VStack(spacing: 20) {
                Text("Create Account")
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
                    .offset(x: -30, y: -80)
                
                // HStack holding the first and last name fields each with their own VStack to
                // match the formatting of the other fields. Notice that the rectangle is slightly
                // shorter for first name than last name to account for the gap between them
                HStack {
                    VStack(spacing: 20) {
                        TextField("First Name", text: $vm.firstName)
                            .textFieldStyle(.plain)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .tint(.white)
                        Rectangle()
                            .frame(width: 165, height: 1)
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 20) {
                        TextField("Last Name", text: $vm.lastName)
                            .textFieldStyle(.plain)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .tint(.white)
                        Rectangle()
                            .frame(width: 175, height: 1)
                            .foregroundColor(.white)
                    }
                }
                
                // Username, email, and password all within the parent VStack
                TextField("Username", text: $vm.username)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .tint(.white)
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                TextField("Email Address", text: $vm.email)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .tint(.white)
                    .keyboardType(.emailAddress)
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $vm.password)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .tint(.white)
                    .onSubmit {
                        vm.createUser { success in
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .submitLabel(.go)
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
                                    .fill(.linearGradient(colors: [Color.primaryAccent, Color.secondaryAccent], startPoint: .top, endPoint: .bottomTrailing))
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
            .environment(\.colorScheme, .dark)
    }
}
