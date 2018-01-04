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
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm";
        dateFormatter.timeZone = TimeZone.current;
        calendarView.onDateSelectBlk = {
            (date:Date?) -> Void in
            print("点击了日期：\(dateFormatter.string(from: date!))");
        } 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

