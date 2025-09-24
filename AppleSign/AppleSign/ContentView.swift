//
//  ContentView.swift
//  AppleSign
//
//  Created by 윤해수 on 7/8/25.
//

import SwiftUI
import SwiftData
import AuthenticationServices
import NormalSkeleton

struct ContentView: View {
    @Environment(\.locale) var locale
    
    @State private var appleUserId: String = ""
    @State private var appleFullName: String = ""
    @State private var appleEmail: String = ""
    @State private var appleIdentityToken: String = ""
    @State private var appleSignInDelegate = AppleSignInDelegate()

    var body: some View {
        VStack(spacing: 20) {
            SkeletonView()
            
            Text("현재 언어: \(locale.identifier)")
            
            Button(action: handleAppleLogin) {
                Label("Sign in with Apple", systemImage: "applelogo")
                    .font(.title2)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            if !appleUserId.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("User ID: \(appleUserId)")
                    Text("Full Name: \(appleFullName)")
                    Text("Email: \(appleEmail)")
                    Text("Token: \(appleIdentityToken)")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("AppleSignInSuccess"))) { notification in
            if let userInfo = notification.userInfo {
                appleUserId = userInfo["userId"] as? String ?? ""
                appleFullName = userInfo["fullName"] as? String ?? ""
                appleEmail = userInfo["email"] as? String ?? ""
                appleIdentityToken = userInfo["token"] as? String ?? ""
            }
        }
    }

    private func handleAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = appleSignInDelegate
        controller.presentationContextProvider = appleSignInDelegate
        controller.performRequests()
    }
}

#Preview {
    ContentView()
}


class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = credential.user
            let fullName = credential.fullName
            let email = credential.email
            let token = credential.identityToken.flatMap { String(data: $0, encoding: .utf8) } ?? ""
            print("Identity Token: \(token)")
            NotificationCenter.default.post(name: Notification.Name("AppleSignInSuccess"), object: nil, userInfo: [
                "userId": userIdentifier,
                "fullName": fullName?.formatted() ?? "",
                "email": email ?? "",
                "token": token
            ])
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign In failed: \(error.localizedDescription)")
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}
