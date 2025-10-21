import SwiftUI

struct IDVerificationView: View {
    @StateObject private var service = IDVerificationService.shared
    @State private var selectedDocumentType: IDVerificationService.DocumentType = .driversLicense
    @State private var showImagePicker = false
    @State private var step: VerificationStep = .documentType
    
    enum VerificationStep {
        case documentType
        case uploadDocument
        case uploadSelfie
        case processing
        case complete
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Progress
                HStack(spacing: 8) {
                    ForEach(0..<5) { index in
                        Rectangle()
                            .fill(index <= stepIndex ? Color.blue : Color.gray.opacity(0.3))
                            .frame(height: 4)
                    }
                }
                .padding(.horizontal)
                
                ScrollView {
                    switch step {
                    case .documentType:
                        documentTypeView
                    case .uploadDocument:
                        uploadDocumentView
                    case .uploadSelfie:
                        uploadSelfieView
                    case .processing:
                        processingView
                    case .complete:
                        completeView
                    }
                }
                
                if step != .processing && step != .complete {
                    PrimaryButton(title: "Continue") {
                        handleContinue()
                    }
                    .padding()
                }
            }
            .navigationTitle("ID Verification")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var stepIndex: Int {
        switch step {
        case .documentType: return 0
        case .uploadDocument: return 1
        case .uploadSelfie: return 2
        case .processing: return 3
        case .complete: return 4
        }
    }
    
    private var documentTypeView: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.shield.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            Text("Verify Your Identity")
                .font(.title.bold())
            
            Text("Choose a document type to verify your identity")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            VStack(spacing: 12) {
                ForEach(IDVerificationService.DocumentType.allCases, id: \.self) { docType in
                    Button(action: {
                        selectedDocumentType = docType
                    }) {
                        HStack {
                            Image(systemName: iconForDocumentType(docType))
                                .font(.title2)
                                .frame(width: 40)
                            Text(docType.rawValue)
                                .font(.headline)
                            Spacer()
                            if selectedDocumentType == docType {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(selectedDocumentType == docType ? Color.blue.opacity(0.1) : Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .foregroundColor(.primary)
                }
            }
            .padding(.horizontal, 40)
        }
    }
    
    private var uploadDocumentView: some View {
        VStack(spacing: 24) {
            Image(systemName: "doc.text.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            Text("Upload Your \(selectedDocumentType.rawValue)")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            Text("Make sure your document is clear and all corners are visible")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: { showImagePicker = true }) {
                VStack(spacing: 16) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    Text("Take Photo")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
            .padding(.horizontal, 40)
            
            VStack(alignment: .leading, spacing: 8) {
                ChecklistItem(text: "Document is in focus")
                ChecklistItem(text: "All corners are visible")
                ChecklistItem(text: "No glare or shadows")
                ChecklistItem(text: "Information is readable")
            }
            .padding(.horizontal, 40)
        }
    }
    
    private var uploadSelfieView: some View {
        VStack(spacing: 24) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            Text("Take a Selfie")
                .font(.title.bold())
            
            Text("We'll compare this with your document photo")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: { showImagePicker = true }) {
                VStack(spacing: 16) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    Text("Take Selfie")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
            .padding(.horizontal, 40)
        }
    }
    
    private var processingView: some View {
        VStack(spacing: 24) {
            ProgressView()
                .scaleEffect(2)
                .padding(.top, 80)
            
            Text("Verifying Your Identity")
                .font(.title.bold())
                .padding(.top, 40)
            
            Text("This may take a few moments")
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
    
    private var completeView: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
                .padding(.top, 80)
            
            Text("Verification Complete!")
                .font(.title.bold())
            
            Text("Your profile is now verified")
                .font(.body)
                .foregroundColor(.secondary)
            
            PrimaryButton(title: "Done") {
                // Dismiss or navigate
            }
            .padding()
        }
    }
    
    private func handleContinue() {
        switch step {
        case .documentType:
            step = .uploadDocument
        case .uploadDocument:
            step = .uploadSelfie
        case .uploadSelfie:
            step = .processing
            Task {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                step = .complete
            }
        default:
            break
        }
    }
    
    private func iconForDocumentType(_ type: IDVerificationService.DocumentType) -> String {
        switch type {
        case .driversLicense: return "car.fill"
        case .passport: return "doc.fill"
        case .nationalID: return "person.text.rectangle.fill"
        case .other: return "doc.text.fill"
        }
    }
}

struct ChecklistItem: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
            Text(text)
                .font(.subheadline)
        }
    }
}
