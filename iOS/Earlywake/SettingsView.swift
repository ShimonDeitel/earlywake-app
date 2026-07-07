import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var purchases: PurchaseManager
    @Environment(\.dismiss) private var dismiss
    @AppStorage("earlywake_notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("earlywake_reminderCategory") private var reminderCategory = true
    @State private var showPaywall = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Reminders", isOn: $notificationsEnabled)
                        .accessibilityIdentifier("settingsRemindersToggle")
                    Toggle("Category Alerts", isOn: $reminderCategory)
                        .accessibilityIdentifier("settingsCategoryToggle")
                }
                Section("Pro") {
                    if purchases.isPro {
                        Label("Pro Unlocked", systemImage: "checkmark.seal.fill")
                            .foregroundStyle(Theme.accent)
                    } else {
                        Button("Upgrade to Pro") { showPaywall = true }
                            .accessibilityIdentifier("settingsUpgradeButton")
                    }
                    Button("Restore Purchases") {
                        Task { await purchases.restore() }
                    }
                    .accessibilityIdentifier("settingsRestoreButton")
                }
                Section("About") {
                    Link("Privacy Policy", destination: URL(string: "https://shimondeitel.github.io/earlywake-app/privacy.html")!)
                    Link("Terms of Use", destination: URL(string: "https://shimondeitel.github.io/earlywake-app/terms.html")!)
                    Text("Version 1.0")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
            .sheet(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }
}
