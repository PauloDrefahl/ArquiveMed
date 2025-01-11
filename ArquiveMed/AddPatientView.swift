import SwiftUI

struct AddPatientPopup: View {
    @Binding var showAddPatientView: Bool
    
    // Example fields
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthDate = Date()

    var body: some View {
        VStack(spacing: 16) {
            
            Spacer()
            
            // Title with icon
            HStack(spacing: 8) {
                Image(systemName: "person.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("Add Patient")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 16)
        
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 16)
            
            
            HStack() {
                
                Text("Appointment Date:")
                    .font(.title3)
                    .fontWeight(.light)
                
                DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                    .padding(.horizontal, 8)
                    .labelsHidden() // or keep the label as needed
            }
            Spacer()
            
            // Buttons
            HStack(spacing: 20) {
                Button(action: {
                    // Handle "Add" action
                    // e.g. validate inputs, store data, etc.
                    // Then close if needed
                    showAddPatientView = false
                }) {
                    Text("Add")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    // Close the popup
                    showAddPatientView = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 20)
    }
}
