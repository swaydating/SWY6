import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Progress Bar
            ProgressBar(progress: viewModel.progress)
                .padding(.horizontal)
                .padding(.top, 8)
            
            // Content
            Group {
                switch viewModel.currentStep {
                case .welcome:
                    WelcomeStepView(viewModel: viewModel)
                case .phoneNumber:
                    PhoneNumberStepView(viewModel: viewModel)
                case .emailAddress:
                    EmailStepView(viewModel: viewModel)
                case .firstName:
                    FirstNameStepView(viewModel: viewModel)
                case .lastName:
                    LastNameStepView(viewModel: viewModel)
                case .dateOfBirth:
                    DateOfBirthStepView(viewModel: viewModel)
                case .gender:
                    GenderStepView(viewModel: viewModel)
                case .location:
                    LocationStepView(viewModel: viewModel)
                case .bio:
                    BioStepView(viewModel: viewModel)
                case .interests:
                    InterestsStepView(viewModel: viewModel)
                case .photos:
                    PhotosStepView(viewModel: viewModel)
                case .complete:
                    CompleteStepView(viewModel: viewModel)
                default:
                    GenericStepView(step: viewModel.currentStep, viewModel: viewModel)
                }
            }
            
            // Navigation Buttons
            HStack(spacing: 16) {
                if viewModel.currentStep != .welcome {
                    Button(action: { viewModel.previousStep() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .frame(width: 50, height: 50)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
                
                if viewModel.currentStep != .complete {
                    Button(action: {
                        if viewModel.currentStep == OnboardingStep.allCases.last {
                            Task {
                                await viewModel.completeOnboarding()
                            }
                        } else {
                            viewModel.nextStep()
                        }
                    }) {
                        Text(viewModel.currentStep == OnboardingStep.allCases.last ? "Finish" : "Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(viewModel.canProceed ? Color.blue : Color.gray)
                            .cornerRadius(25)
                    }
                    .disabled(!viewModel.canProceed)
                }
            }
            .padding()
        }
    }
}
