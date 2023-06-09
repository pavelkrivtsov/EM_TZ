//
//  CellModels.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 26.03.2023.
//

import UIKit

protocol CellTypeProtocol {
    var cellsId: String { get }
    var cellAction: CellGeneralPropertiesProtocol? { get }
    var image: CellImagePropertiesProtocol? { get }
    var label: CellLabelPropertiesProtocol? { get }
    var secondLabel: CellLabelPropertiesProtocol? { get }
}

enum CellType {
    case avatarCell
    case buttonCell
    case labelCell(label: CellLabelPropertiesProtocol)
    case arrowRightCell(image: CellImagePropertiesProtocol,
                        label: CellLabelPropertiesProtocol)
    case withoutArrowRightCell(tapAction: CellGeneralPropertiesProtocol,
                               image: CellImagePropertiesProtocol,
                               label: CellLabelPropertiesProtocol,
                               secondLabel: CellLabelPropertiesProtocol)
}

extension CellType: CellTypeProtocol {
    
    var cellAction: CellGeneralPropertiesProtocol? {
        switch self {
        case .avatarCell:
            return nil
        case .buttonCell:
            return nil
        case .labelCell(_):
            return nil
        case .arrowRightCell(_, _):
            return nil
        case .withoutArrowRightCell(let tapAction, _, _, _):
            return tapAction
        }
    }
    
           
    var cellsId: String {
        switch self {
        case .avatarCell:
            return "AvatarCell"
        case .labelCell(label:_):
            return "LabelCell"
        case .buttonCell:
            return "ButtonCell"
        case .arrowRightCell(image: _, label: _):
            return "ArrowRightCell"
        case .withoutArrowRightCell(tapAction: _, image: _, label: _, secondLabel: _):
            return "WithoutArrowRightCell"
        }
    }
    
    var image: CellImagePropertiesProtocol? {
        switch self {
        case .avatarCell:
            return nil
        case .labelCell(label: _):
            return nil
        case .buttonCell:
            return nil
        case .arrowRightCell(image: let image, label: _):
            return image
        case .withoutArrowRightCell(tapAction: _, image: let image, label: _, secondLabel: _):
            return image
        }
    }
    
    var label: CellLabelPropertiesProtocol? {
        switch self {
        case .avatarCell:
            return nil
        case .labelCell(let label):
            return label
        case .buttonCell:
            return nil
        case .arrowRightCell(image: _, label: let label):
            return label
        case .withoutArrowRightCell(tapAction: _, image: _, label: let label, secondLabel: _):
            return label
        }
    }
    
    var secondLabel: CellLabelPropertiesProtocol? {
        switch self {
        case .avatarCell:
            return nil
        case .labelCell(_):
            return nil
        case .buttonCell:
            return nil
        case .arrowRightCell(_, _):
            return nil
        case .withoutArrowRightCell(_, _, _, let secondLabel):
            return secondLabel
        }
    }
}

protocol CellGeneralPropertiesProtocol {
    var tapAction: (() -> Void)? { get }
}

struct CellGeneralProperties: CellGeneralPropertiesProtocol {
    public var tapAction: (() -> Void)?
}

protocol CellImagePropertiesProtocol {
    var image: UIImage { get }
}

struct CellImageProperties: CellImagePropertiesProtocol {
    var image: UIImage = .init(systemName: "xmark")!
}

protocol CellLabelPropertiesProtocol {
    var title: String { get }
}

struct CellLabelProperties: CellLabelPropertiesProtocol {
    var title: String = ""
}
