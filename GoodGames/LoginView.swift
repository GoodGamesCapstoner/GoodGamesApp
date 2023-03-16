import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var userVM: UserViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color.grayGG
                
                RoundedRectangle(cornerRadius: 3, style: .continuous)
//                    .foregroundStyle(.linearGradient(colors: [.purple, .blue], startPoint:
//                            .topLeading, endPoint: .bottomTrailing))
                    .foregroundColor(.purpleGG)
                    .frame(width: 1000, height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(y: -350)
                if userVM.isUserAuthenticated != .signedIn {
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
                        
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.white)
                        
                        SecureField("Password",text: $userVM.password)
                            .textFieldStyle(.plain)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .tint(.white)
                        
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
                                        .fill(.linearGradient(colors: [Color.purpleGG, Color.lightPurpleGG], startPoint: .top, endPoint: .bottomTrailing))
                                )
                                .foregroundColor(.white)
                        }
                        .padding(.top)
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
                }
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
