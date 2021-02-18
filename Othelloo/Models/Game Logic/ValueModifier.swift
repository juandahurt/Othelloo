//
//  ValueModifier.swift
//  Othelloo
//
//  Created by juandahurt on 17/02/21.
//

import Foundation

struct ValueModifier {
    var valueType: ValueType
    var modifier: (inout Int, inout Int?) -> Void
    var stopCondition: (Int, Int?) -> Bool
    
    /// Chooses the correct modifier
    /// - Parameter direction: movement direction
    /// - Returns: The correct modifier.
    static func chooseModifier(direction: Movement.Direction) -> ValueModifier? {
        switch direction {
        case .top:
            return ValueModifier(
                valueType: .row,
                modifier: { value,_  in
                    value -= 1
                },
                stopCondition: { value,_ in
                    value == -1
                }
            )
        case .right:
            return ValueModifier(
                valueType: .column,
                modifier: { value,_ in
                    value += 1
                },
                stopCondition: { value,_ in
                    value == 8
                }
            )
        case .bottom:
            return ValueModifier(
                valueType: .row,
                modifier: { value,_ in
                    value += 1
                },
                stopCondition: { value,_ in
                    value == 8
                }
            )
        case .left:
            return ValueModifier(
                valueType: .column,
                modifier: { value,_ in
                    value -= 1
                },
                stopCondition: { value,_ in
                    value == -1
                })
        case .topLeft:
            return ValueModifier(
                valueType: .both,
                modifier: { row,col in
                    row -= 1
                    col! -= 1
                },
                stopCondition: { row,col in
                    row == -1 || col == -1
                })
        case .topRight:
            return ValueModifier(
                valueType: .both,
                modifier: { row,col in
                    row -= 1
                    col! += 1
                },
                stopCondition: { row,col in
                    row == -1 || col == 8
                })
        case .bottomRight:
            return ValueModifier(
                valueType: .both,
                modifier: { row,col in
                    row += 1
                    col! += 1
                },
                stopCondition: { row,col in
                    row == 8 || col == 8
                })
        case .bottomLeft:
            return ValueModifier(
                valueType: .both,
                modifier: { row,col in
                    row += 1
                    col! -= 1
                },
                stopCondition: { row,col in
                    row == 8 || col == -1
                })
        }
    }
}

enum ValueType {
    case column
    case row
    case both
}
