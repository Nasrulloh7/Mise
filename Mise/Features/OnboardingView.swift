//
//  OnboardingView.swift
//  Mise
//
//  Created by Rachel Chen on 02/05/26.

import SwiftUI
import AVFoundation
import Photos

enum OnboardingStep: Equatable {
    case splash
    case camera
    case denied(PermissionType)
}

enum PermissionType: Equatable {
    case camera
    case photos

    var deniedTitle: String {
        switch self {
        case .camera: return "Camera Access Denied"
        case .photos: return "Photos Access Denied"
        }
    }

    var deniedDescription: String {
        switch self {
        case .camera:
            return "Please allow camera access in Settings\nso Mise can guide your shots."
        case .photos:
            return "Please allow photo library access in Settings\nso Mise can save your captures."
        }
    }

    var sfSymbol: String {
        switch self {
        case .camera: return "camera"
        case .photos: return "photo"
        }
    }
}

// MARK: Splash Screen
struct SplashView: View {
    let onCapture: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            MiseLogoView()

            Spacer()

            VStack(spacing: 14) {
                Text("Welcome to Misé")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 16)

                Text("Make every dish look irresistible.\nMise handles the composition, you take the shot.")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, 40)

            PrimaryButton(title: "Capture your first photo", action: onCapture)
                .padding(.horizontal, 24)

            Spacer()
        }
    }
}

// Mise Logo (view in Assets)
struct MiseLogoView: View {
    var diameter: CGFloat = 211

    var body: some View {
        Image("Logo Mise App")
            .resizable()
            .scaledToFit()
            .frame(width: diameter, height: diameter)
    }
}

// MARK: Flow
struct OnboardingView: View {
    @State private var step: OnboardingStep = .splash

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            screenContent
        }
    }

    @ViewBuilder
    private var screenContent: some View {
        switch step {

        case .splash:
            SplashView(onCapture: { requestPermissionsAndProceed() })
                .transition(.opacity)

        case .denied(let type):
            PermissionDeniedView(
                permissionType: type,
                onGoToPermission: { openSettings() },
                onExit: { navigate(to: .splash) },
                onRetryAfterSettings: { requestPermissionsAndProceed() }
            )
            .transition(.opacity)

        case .camera:
            CameraView()
                .transition(.opacity)
        }
    }

    private func requestPermissionsAndProceed() {
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
        let photosStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)

        if cameraStatus == .denied || cameraStatus == .restricted || cameraStatus == .notDetermined {
            navigate(to: .denied(.camera))
        } else if photosStatus == .denied || photosStatus == .restricted || photosStatus == .notDetermined {
            navigate(to: .denied(.photos))
        } else {
            navigate(to: .camera)
        }
    }

    private func navigate(to newStep: OnboardingStep) {
        withAnimation(.easeInOut(duration: 0.38)) {
            step = newStep
        }
    }

    private func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

    // MARK: Access Denied Screen (Negative Flow)
    struct PermissionDeniedView: View {
        let permissionType: PermissionType
        let onGoToPermission: () -> Void
        let onExit: () -> Void
        var onRetryAfterSettings: (() -> Void)?

        @Environment(\.scenePhase) private var scenePhase

        var body: some View {
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text("Permission Needed")
                        .font(.system(size: 20, weight: .light))
                        .foregroundStyle(.white)

                    Text(permissionType.deniedTitle)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)

                    Text(permissionType.deniedDescription)
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.top, 4)
                }
                .padding(.horizontal, 36)
                .padding(.top, 60)

                Spacer()
                PermissionIcon(systemName: permissionType.sfSymbol)
                Spacer()

                VStack(spacing: 18) {
                    PrimaryButton(title: "Go to Access Page", action: onGoToPermission)
                    TextButton(title: "Exit", action: onExit)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 100)
            }
            .onChange(of: scenePhase) { _, newPhase in
                guard newPhase == .active else { return }
                checkIfPermissionGrantedAfterSettings()
            }
        }

        private func checkIfPermissionGrantedAfterSettings() {
            switch permissionType {
            case .camera:
                if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
                    onRetryAfterSettings?()
                }
            case .photos:
                let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
                if status == .authorized || status == .limited {
                    onRetryAfterSettings?()
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
