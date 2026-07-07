import Foundation

struct AlarmEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var createdAt: Date = Date()
    var alarmWorked: Bool
    var soundType: String

    init(id: UUID = UUID(), createdAt: Date = Date(), alarmWorked: Bool = true, soundType: String = "Default") {
        self.id = id
        self.createdAt = createdAt
        self.alarmWorked = alarmWorked
        self.soundType = soundType
    }
}
