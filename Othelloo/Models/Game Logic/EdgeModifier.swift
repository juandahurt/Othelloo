//
//  ValueModifier.swift
//  Othelloo
//
//  Created by juandahurt on 17/02/21.
//

import Foundation

struct EdgeModifier {
    var edge: Edge
    var modifier: (inout Int, inout Int?) -> Void
    var stopCondition: (Int, Int?) -> Bool
    
    /// Chooses the correct modifier
    /// - Parameter direction: movement direction
    /// - Returns: The correct modifier.
    static func chooseModifier(direction: Movement.Direction) -> EdgeModifier? {
        switch direction {
        case .top:
            return EdgeModifier(
                edge: .horizontal,
                modifier: { value,_  in
                    value -= 1
                },
                stopCondition: { value,_ in
                    value == -1
                }
            )
        case .right:
            return EdgeModifier(
                edge: .vertical,
                modifier: { value,_ in
                    value += 1
                },
                stopCondition: { value,_ in
                    value == 8
                }
            )
        case .bottom:
            return EdgeModifier(
                edge: .horizontal,
                modifier: { value,_ in
                    value += 1
                },
                stopCondition: { value,_ in
                    value == 8
                }
            )
        case .left:
            return EdgeModifier(
                edge: .vertical,
                modifier: { value,_ in
                    value -= 1
                },
                stopCondition: { value,_ in
                    value == -1
                })
        case .topLeft:
            return EdgeModifier(
                edge: .all,
                modifier: { row,col in
                    row -= 1
                    col! -= 1
                },
                stopCondition: { row,col in
                    row == -1 || col == -1
                })
        case .topRight:
            return EdgeModifier(
                edge: .all,
                modifier: { row,col in
                    row -= 1
                    col! += 1
                },
                stopCondition: { row,col in
                    row == -1 || col == 8
                })
        case .bottomRight:
            return EdgeModifier(
                edge: .all,
                modifier: { row,col in
                    row += 1
                    col! += 1
                },
                stopCondition: { row,col in
                    row == 8 || col == 8
                })
        case .bottomLeft:
            return EdgeModifier(
                edge: .all,
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

enum Edge {
    case vertical
    case horizontal
    case all
}
