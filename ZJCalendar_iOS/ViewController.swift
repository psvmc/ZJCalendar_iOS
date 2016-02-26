//
//  ViewController.swift
//  ZJCalendar_iOS
//
//  Created by 张剑 on 16/2/26.
//  Copyright © 2016年 张剑. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calendarView: WHUCalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.onDateSelectBlk = {
            (date:NSDate!) -> Void in
            print("点击了日期：\(date)");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

