//
//  UIView+Constraints.swift
//  RecrutDemo
//
//  Created by Muhammed Rashid on 15/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

import UIKit

extension UIView {
    /// Creates a constraint that defines the relationship between the specified attributes of a view with another view
    /// - Parameters:
    ///   - attr1: The attribute of the current view for the left side of the constraint.
    ///   - attr2: The attribute of the view for the right side of the constraint.
    ///   - view2: The view for the right side of the constraint.
    ///   - relatedBy: The relationship between the left side of the constraint and the right side of the constraint.
    ///   - multiplier: The constant multiplied with the attribute on the right side of the constraint as part of getting the modified attribute.
    ///   - constant: The constant added to the multiplied attribute value on the right side of the constraint to yield the final modified attribute.
    ///   - priority: The priority of the constraint.
    ///   - isActive: The active state of the constraint.
    /// - Returns: the created constraint in case you wish to hold onto it.
    @discardableResult public func pin(
        _ attr1: NSLayoutConstraint.Attribute,
        to attr2: NSLayoutConstraint.Attribute = .notAnAttribute,
        of view2: Any? = nil,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant const: CGFloat = 0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attr1,
            relatedBy: relation,
            toItem: view2,
            attribute: attr2,
            multiplier: multiplier,
            constant: const
        )
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
    
    /// pin size with dimension
    @discardableResult
    func pinSize(
        _ dimension: CGFloat,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        pinSize(CGSize(width: dimension, height: dimension), relatedBy: relation, priority: priority)
    }
    
    /// pin size with size
    @discardableResult
    func pinSize(
        _ size: CGSize,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        let width = pin(.width, relatedBy: relation, constant: size.width, priority: priority)
        let height = pin(.height, relatedBy: relation, constant: size.height, priority: priority)
        return (width: width, height: height)
    }
}
