import SwiftUI

struct ReAuthenticateView: View {
    @Binding var canDelete: Bool
    @Binding var showAuth: Bool
    @State private var password = ""
    @State private var errorText = ""
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
                    SecureField("Enter your password", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty) {
                        Text("Enter your password")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    Button {
                        AuthManager().reauthenticateWithPassword(password: password) { result in
                            handleResult(result: result)
                        }
                    } label: {
                        Text("Authenticate")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    }
                    .opacity(password.isEmpty ? 0.6 : 1)
                    .disabled(password.isEmpty)
                    
                    Text(errorText)
                        .foregroundColor(.red)
                        .fixedSize(horizontal: false, vertical: true)
                    Button {
                        withAnimation {
                            showAuth = false
                        }
                    } label: {
                        Text("Cancel")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.bordered)
                }
                .frame(width: 350)
            }
            .ignoresSafeArea()
    }
    func handleResult(result: Result<Bool, Error>) {
        switch result {
        case .success:
            // Reauthenticated now so you can delete
            canDelete = true
            showAuth = false
        case .failure(let error):
            errorText = error.localizedDescription
        }
    }
}

struct ReAuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        ReAuthenticateView(canDelete: .constant(false), showAuth: .constant(true))
    }
}
