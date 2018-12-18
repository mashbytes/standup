import Foundation

extension Int {
    
    private var second: TimeInterval {
        return 1
    }
    
    var seconds: TimeInterval {
        return TimeInterval(exactly: self)! * second
    }
    
    private var minute: TimeInterval {
        return 60 * second
    }
    
    var minutes: TimeInterval {
        return Double(exactly: self)! * minute
    }
    
    private var hour: TimeInterval {
        return 60 * minute
    }
    
    var hours: TimeInterval {
        return Double(exactly: self)! * hour
    }
    
    private var day: TimeInterval {
        return 24 * hour
    }
    
    var days: TimeInterval {
        return Double(exactly: self)! * day
    }
    
}
