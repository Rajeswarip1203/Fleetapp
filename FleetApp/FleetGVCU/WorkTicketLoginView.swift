import SwiftUI

struct WorkTicketLoginView: View {
    
    @State private var staffID: String = "admin@gov.com"
    @State private var password: String = "123456"
    @State private var isPasswordVisible: Bool = false
    @State private var showError: Bool = false
    @Binding var isLoggedIn: Bool

    // Dummy credentials
    private let dummyUsername = "admin@gov.com"
    private let dummyPassword = "123456"
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                // MARK: - Background Gradient
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.12, blue: 0.20),
                        Color(red: 0.10, green: 0.25, blue: 0.40)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        
                        Spacer(minLength: 40)
                        
                        // MARK: - Header
                        VStack(spacing: 16) {
                            Image(systemName: "building.columns.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                                .frame(width: 80, height: 80)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            Text("Work Ticket")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                            
                            Text("Official Government Vehicle Portal")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        // MARK: - Glass Card
                        VStack(spacing: 25) {
                            
                            // Staff ID
                            VStack(alignment: .leading, spacing: 8) {
                                Text("STAFF ID / EMAIL")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                                
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.white.opacity(0.6))
                                    
                                    TextField("admin@gov.com", text: $staffID)
                                        .foregroundColor(.white)
                                        .autocapitalization(.none)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.white.opacity(0.08))
                                )
                            }
                            
                            // Password
                            VStack(alignment: .leading, spacing: 8) {
                                Text("PASSWORD")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                                
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.white.opacity(0.6))
                                    
                                    if isPasswordVisible {
                                        TextField("123456", text: $password)
                                            .foregroundColor(.white)
                                    } else {
                                        SecureField("123456", text: $password)
                                            .foregroundColor(.white)
                                    }
                                    
                                    Button {
                                        isPasswordVisible.toggle()
                                    } label: {
                                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                            .foregroundColor(.white.opacity(0.6))
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.white.opacity(0.08))
                                )
                            }
                            
                            // Error Message
                            if showError {
                                Text("Invalid username or password")
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                            
                            // Login Button
                            Button(action: loginUser) {
                               // isLoggedIn = true
                                HStack {
                                    Spacer()
                                    Text("Login to Portal")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.blue)
                                )
                            }
                            .padding(.top, 10)
                            
                            // Forgot Password
                            Button("Forgot Password?") { }
                                .foregroundColor(.blue)
                            
                            // Divider Section
                            HStack {
                                Rectangle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(height: 1)
                                
                                Text("QUICK ACCESS")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.6))
                                
                                Rectangle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(height: 1)
                            }
                            .padding(.vertical, 10)
                            
                            // Biometric Login (UI only)
                            VStack(spacing: 12) {
                                Button {
                                    print("Biometric tapped")
                                } label: {
                                    Image(systemName: "touchid")
                                        .font(.system(size: 40))
                                        .foregroundColor(.blue)
                                        .frame(width: 90, height: 90)
                                        .background(
                                            Circle()
                                                .fill(Color.white.opacity(0.08))
                                        )
                                }
                                
                                Text("Biometric Login")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        .padding(25)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.ultraThinMaterial)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                )
                        )
                        .padding(.horizontal)
                        
                        // MARK: - Footer
                        VStack(spacing: 12) {
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.shield.fill")
                                Text("SECURE GOVERNMENT SESSION")
                                    .font(.caption.bold())
                            }
                            .foregroundColor(.white.opacity(0.6))
                            
                            Text("Unauthorized access to this government system is prohibited and subject to criminal prosecution. Your IP and activity are monitored for security purposes.")
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.4))
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 40)
                    }
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                    DashboardView()
            }
        }
    }
}
    
    // MARK: - Login Logic
    private func loginUser() {
        if staffID == dummyUsername && password == dummyPassword {
            showError = false
            isLoggedIn = true
        } else {
            showError = true
        }
    }
}


// MARK: - Home Screen

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Welcome to Fleet Dashboard 🚘")
                    .font(.title.bold())
                
                Text("Login Successful")
                    .foregroundColor(.gray)
            }
        }
    }
}


