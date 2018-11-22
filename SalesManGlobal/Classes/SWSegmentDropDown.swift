//
//  SWSegmentDropDown.swift
//  SalesManGlobal
//
//  Created by 谢艳 on 2018/11/21.
//

import UIKit

@available(iOS 9.0, *)
public class SWSegmentDropDown: UIView {

    @IBOutlet weak var segmentStackView: UIStackView!
    @IBOutlet weak var tableStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    private(set) var tableViewArray: [UITableView]?
    private(set) var dataSource:[NSArray]?
    private(set) var defaultTitles:[String]?
    private(set) var allowMultipleSelect:Bool = false
    private(set) var lastSelectedSegmentIndex:NSInteger?
    private(set) var selectedTableViewIndexArray:[NSInteger]?
    var highlightedColor:UIColor?
    var titleColor:UIColor?
    var segmentImage:UIImage?
    var segmentHighlightedImage:UIImage?
    var numberOfTable = 0
    override public func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        self.containerView.backgroundColor = UIColor.clear
        self.containerView.isHidden = true
    }
// MARK Public
    public func segmentWithTitles(defaultTitles:[String],dataSource:[NSArray],allowMultipleSelect:Bool){
        self.defaultTitles = defaultTitles
        self.dataSource = dataSource
        self.allowMultipleSelect = allowMultipleSelect
        self.addSubviews()
    }
}
//MARK Private
@available(iOS 9.0, *)
extension SWSegmentDropDown{
    func addSubviews() {
        guard let _ = self.defaultTitles else {
            return
        }
        for (index,title) in self.defaultTitles!.enumerated() {
            let button = self.segmentBtn(title: title)
            button.tag = index
            self.segmentStackView.addArrangedSubview(button)
        }
    }
    func segmentBtn(title:String) -> UIButton {
        let button:UIButton = UIButton.init(type: .custom)
        button.setTitle(title, for: .normal)
        button.setImage(segmentImage ?? nil, for: .normal)
        button.setImage(segmentHighlightedImage ?? nil, for: .highlighted)
        button.addTarget(self, action: #selector(segmentAction), for: .touchUpInside)
        button.setTitleColor(titleColor ?? UIColor.black, for: .normal)
        return button
    }

    func numberOfChainTable(valueArray:NSArray) {
        self.numberOfTable = valueArray.count
    }
    func tableViewWithIndex(index:NSInteger) -> UITableView {
        let tableView = UITableView.init(frame: CGRect.init(origin: CGPoint.zero, size: self.tableStackView.frame.size))
        tableView.tag = index
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }
    func animateTableView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect.init(origin: CGPoint.zero, size: self.frame.size)
        }) { (result) in
            self.frame = CGRect.init(origin: CGPoint.zero, size: (self.superview?.frame.size)!)
        }
    }
    func dataSourceOfTable(segmentIndex:NSInteger,tableIndex:NSInteger,selectedIndexArray:[NSInteger]?) -> NSArray? {
        var tempArray:NSArray? = nil
        let dataSource = self.dataSource![segmentIndex]
        let callBack = { (array : NSArray,tableIndex:NSInteger) ->NSArray?  in
            guard selectedIndexArray != nil else {
                return nil
            }
            var tempArray:NSArray? = array
            for index in 0..<(tableIndex-1) {
                if (tempArray?.count)! <= selectedIndexArray![index]{
                    tempArray = nil
                    break
                }
                tempArray = (tempArray![selectedIndexArray![index]] as? NSArray)
            }
            return tempArray ?? nil
        }
        switch tableIndex {
        case 1:
            tempArray = (dataSource[0] as! NSArray)
        default:
            if dataSource.count <= tableIndex-1{
                return nil
            }
            tempArray = callBack(dataSource[tableIndex-1] as! NSArray,tableIndex)
        }
        return tempArray
    }
}

//MARK Action
@available(iOS 9.0, *)
extension SWSegmentDropDown {
    @objc func segmentAction(button:UIButton) {
        if lastSelectedSegmentIndex == button.tag {
            self.containerView.isHidden = !self.containerView.isHidden
            if self.containerView.isHidden  {
                self.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.frame.size.width, height: 44))
                self.containerView.backgroundColor = UIColor.clear
                button.setTitleColor(UIColor.lightGray, for: .normal)
                return
            } else {
                button.setTitleColor(UIColor.swThemeColor(), for: .normal)
            }
        } else {
            if let _ = lastSelectedSegmentIndex {
                let tempButton:UIButton = self.segmentStackView.arrangedSubviews[lastSelectedSegmentIndex!] as! UIButton
                tempButton.setTitleColor(UIColor.lightGray, for: .normal)
            }
            self.containerView.isHidden = false
            button.setTitleColor(UIColor.swThemeColor(), for: .normal)
        }
        self.lastSelectedSegmentIndex = button.tag
        self.numberOfTable = 0
        self.tableStackView.isHidden = false
        self.numberOfChainTable(valueArray: self.dataSource![button.tag])
        let tempArray:NSMutableArray = NSMutableArray.init()
        for view in self.tableStackView.arrangedSubviews {
            self.tableStackView.removeArrangedSubview(view)
        }
        self.containerView.backgroundColor = self.numberOfTable > 1 ? UIColor.white :UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        for index in 1...self.numberOfTable {
            let tableView = self.tableViewWithIndex(index: index)
            if(index == 1) {
                tableView.reloadData()
            }
            tempArray.add(tableView)
            self.tableStackView.addArrangedSubview(tableView)
        }
        self.tableViewArray = tempArray.copy() as? [UITableView]
        //animation frame
        self.animateTableView()
    }
}
@available(iOS 9.0, *)
extension SWSegmentDropDown:UITableViewDataSource,UITableViewDelegate{
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (self.dataSourceOfTable(segmentIndex: self.lastSelectedSegmentIndex!, tableIndex: tableView.tag, selectedIndexArray: self.selectedTableViewIndexArray)?.count) ?? 0
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextTag = tableView.tag + 1
        if (self.tableViewArray?.count)! >= nextTag {
            var tempArray:NSMutableArray?
            if self.selectedTableViewIndexArray == nil {
                tempArray = NSMutableArray.init(capacity: (self.tableViewArray?.count)!)
            } else {
                tempArray = NSMutableArray.init(array: self.selectedTableViewIndexArray!)
            }
            tempArray!.insert(indexPath.row, at: (tableView.tag-1))
            self.selectedTableViewIndexArray = (tempArray as! [NSInteger])
            let tableView:UITableView = self.tableViewArray![nextTag-1]
            tableView.isHidden = false
            tableView.reloadData()
        } else {
            
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let tempDataSource = self.dataSourceOfTable(segmentIndex: self.lastSelectedSegmentIndex!, tableIndex: tableView.tag, selectedIndexArray: self.selectedTableViewIndexArray)
        cell?.textLabel?.text = tempDataSource![indexPath.row] as? String ?? ""
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.white
        return cell!
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
}
