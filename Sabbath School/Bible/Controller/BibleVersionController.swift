/*
 * Copyright (c) 2017 Adventech <info@adventech.io>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import AsyncDisplayKit
import UIKit

struct MenuItem {
    var name: String
    var subtitle: String?
    var image: UIImage?
    var selected: Bool?

    static var height: CGFloat {
        return 51.5
    }
}

protocol BibleVersionControllerDelegate: AnyObject {
    func didSelectVersion(versionName: String)
}

class BibleVersionController: ASDKViewController<ASDisplayNode>, ASTableDataSource, ASTableDelegate {
    weak var delegate: BibleVersionControllerDelegate?
    var table: ASTableNode { return node as! ASTableNode }
    var items = [MenuItem]()

    init(withItems items: [MenuItem]) {
        super.init(node: ASTableNode())
        table.delegate = self
        table.dataSource = self
        table.view.separatorColor = AppStyle.Base.Color.tableSeparator
        table.view.backgroundColor = AppStyle.Base.Color.background
        self.items = items
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }

    func tableView(_ tableView: ASTableView, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let menuItem = items[indexPath.row]

        let cellBlock: () -> ASCellNode = {
            return BibleVersionView(name: menuItem.name, isSelected: menuItem.selected ?? false)
        }
        return cellBlock
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss {
            self.delegate?.didSelectVersion(versionName: self.items[indexPath.row].name)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.table.view.separatorColor = AppStyle.Base.Color.tableSeparator
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if UIApplication.shared.applicationState != .background && self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                table.reloadData()
                self.popoverPresentationController?.backgroundColor = AppStyle.Base.Color.background
            }
        }
    }
}

extension BibleVersionController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
