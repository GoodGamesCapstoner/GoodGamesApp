import SwiftUI
import FirebaseAuth

struct LoginView: View {
//    @StateObject var vm = ViewModel()
    @EnvironmentObject var userVM: UserViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                
                RoundedRectangle(cornerRadius: 3, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.purple, .blue], startPoint:
                            .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1000, height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(y: -350)
                if userVM.isUserAuthenticated != .signedIn {
                    VStack(spacing: 20) {
                        Text("Welcome")
                            .foregroundColor(.white)
                            .font(.system(size:40, weight: .bold, design: .rounded))
                            .offset(x: -100, y: -100)
                        
                        TextField("Email", text: $userVM.email)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: userVM.email.isEmpty) {
                                Text("Email")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.white)
                        
                        SecureField("Password",text: $userVM.password)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: userVM.password.isEmpty) {
                                Text("Password")
                                    .foregroundColor(.white)
                                    .bold()
                            }
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
                                        .fill(.linearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottomTrailing))
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
                        .sheet(isPresented: $userVM.newAccount) {
                            SignUpView()
                        }
                    }
                    .frame(width: 350)
                    //                        .padding()
                    //                        .textFieldStyle(.roundedBorder)
                    //                        .autocapitalization(.none)
                } else {
                    //UserProfileView()
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            //vm.configureFirebaseStateDidChange()
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
        LoginView().environmentObject(UserViewModel())
    }
}
