//
//  NeedsLayout.swift
//  GridView
//
//  Created by Kyohei Ito on 2016/12/28.
//  Copyright © 2016年 Kyohei Ito. All rights reserved.
//

enum NeedsLayout {
    case none, reload, layout(LayoutType)
    
    enum LayoutType {
        case all(ViewMatrix), vertically(ViewMatrix), rotating(ViewMatrix), pinching(ViewMatrix)
    }
}

extension NeedsLayout: Equatable {
    static func ==(lhs: NeedsLayout, rhs: NeedsLayout) -> Bool {
        switch (lhs, rhs) {
        case (none, none), (reload, reload), (layout, layout):
            return true
        default:
            return false
        }
    }
}

extension NeedsLayout: Comparable {
    static func <(lhs: NeedsLayout, rhs: NeedsLayout) -> Bool {
        switch rhs {
        case .reload:
            switch lhs {
            case .reload:
                return false
            default:
                return true
            }
        case .layout:
            switch lhs {
            case .reload, .layout:
                return false
            default:
                return true
            }
        case .none:
            return false
        }
    }
}

extension NeedsLayout.LayoutType {
    var matrix: ViewMatrix {
        switch self {
        case .all(let m), .vertically(let m), .rotating(let m), .pinching(let m):
            return m
        }
    }
}

extension NeedsLayout.LayoutType: Equatable {
    static func ==(lhs: NeedsLayout.LayoutType, rhs: NeedsLayout.LayoutType) -> Bool {
        switch (lhs, rhs) {
        case (all, all), (vertically, vertically), (rotating, rotating), (pinching, pinching):
            return true
        default:
            return false
        }
    }
}

extension NeedsLayout.LayoutType: Comparable {
    static func <(lhs: NeedsLayout.LayoutType, rhs: NeedsLayout.LayoutType) -> Bool {
        switch rhs {
        case .all:
            switch lhs {
            case .all:
                return false
            default:
                return true
            }
        case .vertically:
            switch lhs {
            case .all, .vertically:
                return false
            default:
                return true
            }
        case .rotating:
            switch lhs {
            case .all, .vertically, .rotating:
                return false
            default:
                return true
            }
        case .pinching:
            return false
        }
    }
}
