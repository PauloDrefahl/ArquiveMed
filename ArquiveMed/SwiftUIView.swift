import SwiftUI

struct InitialView: View {
    // Example accounts; replace with real data
    @State private var accounts: [String] = ["Fabio"]
    
    // A toggle to show/hide your hypothetical expandable menu
    @State private var showMenu = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // --- Custom Nav Bar at the top
                ZStack {
                    // Centered Title
                    Text("Welcome Back !")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Expandable Menu Button on the right side
                    HStack {
                        Spacer()
                        Button(action: {
                            // Toggle your menu’s visibility here
                            showMenu.toggle()
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 12)
                .background(Color.gray.opacity(0.1)) // Light background for the "nav bar"
                
                // Use a Spacer to push the main content to the vertical center
                Spacer(minLength: 0)
                
                // --- Main Content in the middle
                VStack(spacing: 16) {
                    
                    // The Logo (in the same directory, named "ArchiveMedLogo.png")
                    Image("ArchiveMedLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 200)  // Adjust size as desired
                        .padding(.bottom, 8)
                    
                    // Instruction label
                    Text("Please select your account or create a new one.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Display accounts in a vertical list
                    ForEach(accounts, id: \.self) { account in
                        // NavigationLink to push "ContentView"
                        NavigationLink(destination: ContentView()) {
                            Text(account)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                        .buttonStyle(.plain)  // Keep the same "flat" button style
                    }
                    
                    // "Create an Account" button
                    Button(action: {
                        // Navigate to account creation flow
                    }) {
                        Text("Create an Account")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                // Use another Spacer to keep the content centered
                Spacer(minLength: 0)
                
                // --- Bottom "Select Language" Button
                HStack {
                    Spacer()
                    Button(action: {
                        // Handle language selection
                    }) {
                        HStack {
                            Text("Select Language")
                            // US Flag emoji
                            Text("\u{1F1FA}\u{1F1F8}")
                            // Dropdown arrow
                            Text("\u{25BC}")
                        }
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    Spacer()
                }
                .padding(.bottom, 16)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    InitialView()
}
