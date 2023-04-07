import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State var showLoginFailedAlert = false
    @State var showLoadingSpinner = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBackground
                
                RoundedRectangle(cornerRadius: 3, style: .continuous)
                    .foregroundColor(.secondaryBackground)
                    .frame(width: 1000, height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(y: -350)
                
                VStack(spacing: 20) {
                    Text("Welcome to Good Games")
                        .font(.largeTitle)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .offset(x: -60, y: -100)
                    
                    TextField("Email", text: $userVM.email)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .tint(.white)
                        .keyboardType(.emailAddress)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("Password",text: $userVM.password)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .tint(.white)
                        .onSubmit {
                            userVM.login()
                        }
                        .submitLabel(.go)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    Button {
                        userVM.login()
                    } label: {
                        Text("Log In")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [Color.primaryAccent, Color.secondaryAccent], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .alert("Login Failed", isPresented: $userVM.authFailed) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        if let warning = userVM.authFailedWarning {
                            Text(warning)
                        }
                    }

                    
                    Button {
                        userVM.newAccount = true
                    } label: {
                        Text("Create Account")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .sheet(isPresented: $userVM.newAccount) {
                        SignUpView()
                            .environment(\.colorScheme, .dark)
                    }
                }
                .frame(width: 350)
                .alert("Login Unsuccessful", isPresented: $showLoginFailedAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("We were unable to locate your account details. Please try again later or create a new account.")
                }
                
            }
            .onAppear {
                self.showLoginFailedAlert = userVM.userMissingFromFirestore
            }
            .ignoresSafeArea()
        }
    }
}



// Extends base View to allow placeholders
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}
