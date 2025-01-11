import SwiftUI
import UIKit

struct SelectPatientPopup: View {
    /// Controls whether this popup is shown.
    @Binding var showSelectPatientView: Bool
    
    /// The list of all patients available for searching.
    let allPatients: [String]
    
    /// A binding to the array where you want to store the captured images.
    /// This lets the camera's captured photos flow back to the parent.
    @Binding var capturedImages: [UIImage]
    
    /// State for displaying the camera sheet.
    @State private var showCameraSheet = false
    
    /// State for the search text
    @State private var searchText = ""
    
    /// Which patient was tapped (so we know we're adding photos to them).
    @State private var selectedPatient: String? = nil
    
    /// Filter the patient list in real-time
    var filteredPatients: [String] {
        guard !searchText.isEmpty else {
            return allPatients
        }
        return allPatients.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            // Title with icon
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("Select Patient")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            // Search bar
            TextField("Search by name...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 16)
            
            // A scrollable list of filtered patients
            // Each row is a Button. Tapping it:
            // 1) Sets selectedPatient.
            // 2) Opens the camera sheet.
            List(filteredPatients, id: \.self) { patient in
                Button {
                    // Mark the selected patient
                    selectedPatient = patient
                    
                    // Trigger the camera
                    showCameraSheet = true
                } label: {
                    Text(patient)
                        .padding(.vertical, 6)
                }
                // Use a default button style or a custom style
                .buttonStyle(.automatic)
            }
            
            Spacer()
            
            // Cancel button at the bottom
            HStack(spacing: 20) {
                Button(action: {
                    showSelectPatientView = false
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
        // Present the camera picker once a row is tapped
        .sheet(isPresented: $showCameraSheet) {
            // We can show a custom camera or
            // the standard CameraPicker from your code
            CameraPicker(images: $capturedImages)
        }
    }
}
