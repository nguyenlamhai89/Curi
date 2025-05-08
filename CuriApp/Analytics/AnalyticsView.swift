//
//  AnalyticsView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 6/5/25.
//

import SwiftUI
import FirebaseAnalytics

final class AnalyticsManager {
    
    static let access = AnalyticsManager()
    
    func logEvents(name: String, params: [String: Any]? = nil) {
        Analytics.logEvent(name, parameters: params)
    }
    
    func setUserID(userID: String) {
        Analytics.setUserID(userID)
    }
    
    func setUserProperty(value: String?, forName: String) {
        Analytics.setUserProperty(value, forName: forName)
    }
}

struct AnalyticsView: View {
    @State var appearTime: Date?
    @State var isPresentedSheet1: Bool = false
    @State var isPresentedSheet2: Bool = false
    
    var body: some View {
        VStack {
            Button {
                isPresentedSheet1.toggle()
                AnalyticsManager.access.logEvents(name: "buttonPlay_tap")
            } label: {
                Text("Go to Sheet 1")
            }

            Button {
                isPresentedSheet2.toggle()
                AnalyticsManager.access.logEvents(name: "buttonPause_tap", params: [
                    "param1": "Hello world"
                ])
            } label: {
                Text("Go to Sheet 2")
            }
        }
        .sheet(isPresented: $isPresentedSheet1, content: {
            NavigationView { // Sheet 1
                Button {
                    isPresentedSheet1.toggle()
                } label: {
                    Text("Okay")
                }
                .navigationTitle("Sheet 1")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                appearTime = Date()
                AnalyticsManager.access.logEvents(name: "sheet1_appear")
            }
            .onDisappear {
                if let appearTime = appearTime {
                    let duration = Date().timeIntervalSince(appearTime)
                    AnalyticsManager.access.logEvents(name: "sheet1_disappear", params: [
                        "durationOnSheet1": duration
                    ])
                    print(duration)
                }
            }
        })
        .sheet(isPresented: $isPresentedSheet2, content: {
            NavigationView { // Sheet 1
                Button {
                    isPresentedSheet2.toggle()
                } label: {
                    Text("Okay")
                }
                .navigationTitle("Sheet 2")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                appearTime = Date()
                AnalyticsManager.access.logEvents(name: "sheet2_appear")
            }
            .onDisappear {
                if let appearTime = appearTime {
                    let duration = Date().timeIntervalSince(appearTime)
                    AnalyticsManager.access.logEvents(name: "sheet2_disappear", params: [
                        "durationOnSheet2": duration
                    ])
                    print(duration)
                }
            }
        })
        
    }
}

#Preview {
    AnalyticsView()
}
