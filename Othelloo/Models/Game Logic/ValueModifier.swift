//
//  ValueModifier.swift
//  Othelloo
//
//  Created by juandahurt on 17/02/21.
//

import Foundation

struct ValueModifier {
    var valueType: ValueType
    var modifier: (inout Int) -> Void
    var stopCondition: (Int) -> Bool
    
    /// Chooses the correct modifier
    /// - Parameter direction: movement direction
    /// - Returns: The correct modifier.
    static func chooseModifier(direction: Movement.Direction) -> ValueModifier? {
        switch direction {
        case .top:
            return ValueModifier(
                valueType: .row,
                modifier: { value in
                    value -= 1
                },
                stopCondition: { value in
                    value == -1
                }
            )
        case .right:
            return ValueModifier(
                valueType: .column,
                modifier: { value in
                    value += 1
                },
                stopCondition: { value in
                    value == 8
                }
            )
        case .bottom:
            return ValueModifier(
                valueType: .row,
                modifier: { value in
                    value += 1
                },
                stopCondition: { value in
                    value == 8
                }
            )
        case .left:
            return ValueModifier(
                valueType: .column,
                modifier: { value in
                    value -= 1
                },
                stopCondition: { value in
                    value == -1
                }
            )
        default:
            return nil
        }
    }
}

enum ValueType {
    case column
    case row
}
