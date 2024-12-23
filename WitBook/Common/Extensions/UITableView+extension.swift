//
//  UITableView+extension.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 17.12.2024.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseId)
    }

    func register<T: UITableViewHeaderFooterView>(_: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseId)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseId)")
        }
        return cell
    }

    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.reuseId) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseId)")
        }
        return headerFooter
    }
}
