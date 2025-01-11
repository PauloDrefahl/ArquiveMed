import SwiftUI

// MARK: - Model
struct Patient: Identifiable {
    let id = UUID()
    let name: String
    let registrationDate: Date
}

// MARK: - ContentView
struct ContentView: View {
    
    // Search text (for name)M
    @State private var searchText = ""
    
    // Segment control: "Both", "Name", or "Date"
    @State private var filterOption: String = "Both"
    
    // Date range
    @State private var startDate = Date(timeIntervalSinceNow: -86400 * 7) // 1 week ago
    @State private var endDate = Date()                                  // now
    
    // Example data
    @State private var patients: [Patient] = [
        Patient(name: "Alexander Valley", registrationDate: Date(timeIntervalSinceNow: -86400 * 10)),
        Patient(name: "Maria Gonzalez",   registrationDate: Date(timeIntervalSinceNow: -86400 * 3)),
        Patient(name: "John Smith",       registrationDate: Date())
    ]
    
    // Popup controls (from your original layout)
    @State private var showAddPatientView = false
    @State private var showSelectPatientPopup = false
    @State private var showCamera = false
    @State private var capturedImages: [UIImage] = []
    
    // Computed property for filtering
    private var filteredPatients: [Patient] {
        var results = patients
        
        // If filtering by name or both, apply name filter
        if filterOption == "Name" || filterOption == "Both" {
            if !searchText.isEmpty {
                let lowerSearch = searchText.lowercased()
                results = results.filter {
                    $0.name.lowercased().contains(lowerSearch)
                }
            }
        }
        
        // If filtering by date or both, apply date filter
        if filterOption == "Date" || filterOption == "Both" {
            results = results.filter {
                $0.registrationDate >= startDate && $0.registrationDate <= endDate
            }
        }
        
        return results
    }
    
    var body: some View {
        ZStack {
            
            // Main content
            NavigationView {
                VStack(spacing: 0) {
                    
                    // -- Custom Nav Bar
                    VStack(spacing: 0) {
                        HStack {
                            // Search button (left)
                            Button(action: {
                                // You can handle some search logic if needed
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.black)
                            }
                            .padding(.trailing, 8)
                            
                            Text("Clinica Drefahl")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .padding([.horizontal, .top])
                        
                        // Left-aligned welcome text
                        Text("Welcome, Fabio!")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                    }
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    
                    // -- Main Buttons
                    HStack(spacing: 16) {
                        // Show the popup overlay for AddPatientView
                        Button(action: {
                            showAddPatientView = true
                        }) {
                            HStack {
                                Image(systemName: "person.badge.plus")
                                Text("New Patient")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        
                        // Show SelectPatientPopup or camera
                        Button(action: {
                            showSelectPatientPopup = true
                        }) {
                            HStack {
                                Image(systemName: "camera")
                                Text("add photos")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .sheet(isPresented: $showSelectPatientPopup) {
                            // In your real code, you'd show your SelectPatientPopup here
                            Text("Placeholder for SelectPatientPopup")
                                .presentationDetents([.large])
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                    
                    // -- Search Section (Name, Date, Both)
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "eye")
                                .foregroundColor(.black)
                            Text("Search Patients")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        // Name Search
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            Text("Name:")
                                .fontWeight(.semibold)
                            TextField("Search", text: $searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Date Range
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                            Text("Date:")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            HStack(spacing: 6) {
                                DatePicker("", selection: $startDate, displayedComponents: .date)
                                    .labelsHidden()
                                Text("-")
                                DatePicker("", selection: $endDate, displayedComponents: .date)
                                    .labelsHidden()
                            }
                        }
                        
                        // Segmented Picker
                        HStack {
                            Text("Search By:")
                                .fontWeight(.semibold)
                            Picker("Search By", selection: $filterOption) {
                                Text("Both").tag("Both")
                                Text("Name").tag("Name")
                                Text("Date").tag("Date")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                    
                    // -- “Patients Found” Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "person.2")
                                .foregroundColor(.black)
                            Text("Patients Found")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        // Table of filtered patients
                        VStack(spacing: 0) {
                            // Header row
                            HStack {
                                Text("Patient Name")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("Registered Date")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("...")
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            
                            Divider()
                            
                            // Table rows
                            ForEach(filteredPatients) { patient in
                                HStack {
                                    Button(action: {
                                        // Handle patient name tap
                                    }) {
                                        Text(patient.name)
                                            .foregroundColor(.primary)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Spacer()
                                    // Format the registration date
                                    Text(patient.registrationDate, style: .date)
                                    
                                    Spacer()
                                    Button(action: {
                                        // Action menu for patient row
                                    }) {
                                        Image(systemName: "ellipsis")
                                            .foregroundColor(.gray)
                                    }
                                    .buttonStyle(.plain)
                                }
                                .frame(height: 50)
                                .padding(.horizontal)
                                
                                Divider()
                            }
                        }
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // -- Bottom Navigation
                    HStack {
                        Button(action: {
                            // Action for Add
                        }) {
                            VStack {
                                Image(systemName: "plus")
                                Text("Add")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                        Button(action: {
                            // Action for Settings
                        }) {
                            VStack {
                                Image(systemName: "gear")
                                Text("Settings")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                        Button(action: {
                            // Action for Remove
                        }) {
                            VStack {
                                Image(systemName: "trash")
                                Text("Remove")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                }
                .navigationBarHidden(true)
            }
            
            // Dimmed background + popup for New Patient
            if showAddPatientView {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                
                AddPatientPopup(showAddPatientView: $showAddPatientView)
                    .frame(width: 350, height: 400)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 4)
                    .padding(.horizontal, 20)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
