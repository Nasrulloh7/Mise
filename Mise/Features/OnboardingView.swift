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
    case complete
    case camera
}

// MARK: Splash Screen
struct SplashView: View {
    let onStart: () -> Void

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

            PrimaryButton(title: "Start", action: onStart)
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

// MARK: Access Permission Screen (Camera and Photos)
struct AccessPermissionView: View {
    let permissionType: PermissionType
    let onGranted: () -> Void
    let onDenied: () -> Void

    @State private var isRequesting = false

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 14) {
                Text("Access Needed")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                Text("To unlock the full experience, we need\naccess to your camera and photos.")
                    .font(.system(size: 17))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
            .padding(.horizontal, 28)
            .padding(.top, 60)

            Spacer()

            VStack(spacing: 20) {
                
                // access permission modal should pop up here

            }

            Spacer()

            Text("Your sensitive data is protected and\nnothing is accessed without your permission.")
                .font(.system(size: 17))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
        }
        .onAppear {
            isRequesting = true
            requestPermission()
        }
    }

// AVFoundation Access Permission Request
    private func requestPermission() {
        switch permissionType {

        case .camera:
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                isRequesting = false
                onGranted()
            case .denied, .restricted:
                isRequesting = false
                onDenied()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        isRequesting = false
                        granted ? onGranted() : onDenied()
                    }
                }
            @unknown default:
                isRequesting = false
                onDenied()
            }

        case .photos:
            switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
            case .authorized, .limited:
                isRequesting = false
                onGranted()
            case .denied, .restricted:
                isRequesting = false
                onDenied()
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    DispatchQueue.main.async {
                        isRequesting = false
                        switch status {
                        case .authorized, .limited: onGranted()
                        default: onDenied()
                        }
                    }
                }
            @unknown default:
                isRequesting = false
                onDenied()
            }
        }
    }
}

// MARK: Access Denied Screen (Camera and Photos)
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
 
// MARK: All Set Screen
struct AllSetView: View {
    let onCapture: () -> Void
 
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 12) {
                Text("You're All Set!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
 
                Text("Your photography journey starts here.\nGo capture your best shots.")
                    .font(.system(size: 17))
                    .foregroundStyle(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.top, 4)
            }
            .padding(.horizontal, 32)
            .padding(.top, 60)
 
            Spacer()
            PermissionIcon(systemName: "checkmark.circle")
            Spacer()
 
            VStack(spacing: 18) {
                PrimaryButton(title: "Capture your first photo", action: onCapture)
                Color.clear.frame(height: 44)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 100)
        }
    }
}
 
// Flow
struct OnboardingView: View {
    @State private var step: OnboardingStep = .splash
 
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            screenContent
                .id(step)
        }
    }
 
    @ViewBuilder
    private var screenContent: some View {
        switch step {
 
        case .splash:
            SplashView(onStart: { navigate(to: .complete) })
                .transition(.opacity)
 
        case .complete:
            AllSetView(onCapture: { navigate(to: .camera) }) //change this to camera (next step)
                .transition(.opacity)

        case .camera:
            CameraView()
                .transition(.opacity)
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
}

#Preview{
    OnboardingView()
}
 
