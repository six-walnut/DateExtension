//
//  DateClass.swift
//  XueXueChat
//
//  Created by z on 2019/3/7.
//  Copyright © 2019年 developer@aixuexue.com. All rights reserved.
//
import UIKit

extension String{
    //    var length: Int {
    //        return self.count
    //    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    //不包含后几个字符串的方法
    func dropLast(_ n: Int = 1) -> String {
        return String(self.dropLast(n))
    }
    var dropLast: String {
        return dropLast()
    }
   
    
    //电话号码加*
    var phoneMash:String{
        get{
            return (self.enumerated().map { i,c -> String in
                if [3,4,5,6].contains(i)  {
                    return "*"
                }
                return c.description
            }).joined(separator: "")
        }
    }
    //身份证号码加*
    var idCardMash:String{
        get{
            return (self.enumerated().map { i,c -> String in
                if [0,17].contains(i)  {
                    
                }else{
                    return "*"
                }
                return c.description
            }).joined(separator: "")
        }
    }
    //获取下标对应的字符
    func charAt(pos: Int) -> Character? {
        if pos < 0 || pos >= count {
            return nil   //判断边界条件
        }
        let index = self.index(self.startIndex, offsetBy: pos)
        let str = self[index]
        return Character(String(str))
    }
    func mybase64() -> String {
        //base64编码
        let a = self
        let b = a.data(using: String.Encoding.utf8)
        let c = b!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return c
    }
    
    func myfanbase64() -> String {
        let a = self
        let b = NSData(base64Encoded: a, options: .init(rawValue: 0))! as NSData
        let c = NSString(data: b as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return c
    }
    
}
class DateClass {
    //MARK: - 当前时间相关
    //MARK: 今年
    static func currentYear() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year!
    }
    //MARK: 今月
    static func currentMonth() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.month!
        
    }
    //获取系统的当前时间戳字符串
    static func getStringStamp()->String{
        //获取当前时间戳
        let date = Date()
        let timeInterval:Int = Int(date.timeIntervalSince1970)
        return "\(timeInterval)"
    }
    //获取系统的当前时间戳字符串
    static func getStringMilliStamp()->String{
        //获取当前时间戳
        let date = Date()
        let timeInterval:TimeInterval = TimeInterval(date.timeIntervalSince1970)
        let millisecond = CLongLong(round(timeInterval * 1000))
        return "\(millisecond)"
    }
    //将时间戳转换为月日mm-dd
    static func timeStampToStringHHmm(_ timeStamp:String)->String {
        let string = NSString(string: String(timeStamp.substring(toIndex: 10)))
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="HH:mm"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //MARK: 今日
    static func currentDay() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.day!
        
    }
    //MARK: 今天星期几
    static func currentWeekDay()->Int{
        let interval = Int(Date().timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    //MARK: 本月天数
    static func countOfDaysInCurrentMonth() ->Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: Date())
        return (range?.length)!
        
    }
    //MARK: 当月第一天是星期几
    static func firstWeekDayInCurrentMonth() ->Int {
        //星期和数字一一对应 星期日：7
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date = dateFormatter.date(from: String(Date().year())+"-"+String(Date().month()))
        let calender = Calendar(identifier:Calendar.Identifier.gregorian)
        let comps = (calender as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
        var week = comps?.weekday
        if week == 1 {
            week = 8
        }
        return week! - 1
    }
    //MARK: - 获取指定日期各种值
    //根据年月得到某月天数
    static func getCountOfDaysInMonth(year:Int,month:Int) ->Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date
            = dateFormatter.date(from: String(year)+"-"+String(month))
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date!)
        return (range?.length)!
    }
    //MARK: 根据年月得到某月第一天是周几
    static func getfirstWeekDayInMonth(year:Int,month:Int) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date
            = dateFormatter.date(from: String(year)+"-"+String(month))
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let comps = (calendar as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
        let week = comps?.weekday
        return week! - 1
    }
    
    
    
    //MARK: date转日期字符串
    static func dateToDateString(_ date:Date, dateFormat:String) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    
    
    //MARK: 日期字符串转date
    static func dateStringToDate(_ dateStr:String) ->Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date
            = dateFormatter.date(from: dateStr)
        return date!
    }
    //MARK: 时间字符串转date
    static func timeStringToDate(_ dateStr:String) ->Date {
        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd  HH:mm:ss"
        let date
            = dateFormatter.date(from: dateStr)
        return date ?? Date()
    }
    
    //MARK: 计算天数差
    static func dateDifference(_ dateA:Date, from dateB:Date) -> Double {
        let interval = dateA.timeIntervalSince(dateB)
        return interval/86400
        
    }
    
    //MARK: 比较时间先后
    static func compareOneDay(oneDay:Date, withAnotherDay anotherDay:Date) -> Int {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let oneDayStr:String = dateFormatter.string(from: oneDay)
        let anotherDayStr:String = dateFormatter.string(from: anotherDay)
        let dateA = dateFormatter.date(from: oneDayStr)
        let dateB = dateFormatter.date(from: anotherDayStr)
        let result:ComparisonResult = (dateA?.compare(dateB!))!
        //Date1  is in the future
        if(result == ComparisonResult.orderedDescending ) {
            return 1
            
        }
            //Date1 is in the past
        else if(result == ComparisonResult.orderedAscending) {
            return 2
            
        }
            //Both dates are the same
        else {
            return 0
        }
    }
    
    //MARK: 时间与时间戳之间的转化
    //将时间转换为时间戳
    static func stringToTimeStamp(_ stringTime:String)->Int {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        dfmatter.locale = Locale.current
        
        let date = dfmatter.date(from: stringTime)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        
        return dateSt
    }
    //将时间戳转换为年月日
    static func timeStampToString(_ timeStamp:String)->String {
        let string = NSString(string: String(timeStamp.substring(toIndex: 10)))
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //将时间戳转换为月日
    static func timeStampToStringMMDD(_ timeStamp:String)->String {
        let string = NSString(string: String(timeStamp.substring(toIndex: 10)))
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="MM月dd日"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    //将时间戳转换为年
    static func timeStampToStringyyyy(_ timeStamp:String)->String {
        let string = NSString(string: String(timeStamp.substring(toIndex: 10)))
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //将时间戳转换为月日mm-dd
    static func timeStampToStringmmdd(_ timeStamp:String)->String {
        let string = NSString(string: String(timeStamp.substring(toIndex: 10)))
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="mm-dd"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //将时间戳转换为月日
    static func timeStampToStringddMM(_ timeStamp:String)->String {
        let string = NSString(string: String(timeStamp.substring(toIndex: 10)))
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="ddMM月"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //将时间戳转换为具体时间
    static func timeStampToStringDetail(_ timeStamp:String)->String {
        let string = NSString(string: String(timeStamp.substring(toIndex: 10)))
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日HH:mm:ss"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //将时间戳转换为具体时间
    static func timeStampToStringDetail1(_ timeStamp:String)->String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //将时间戳转换为时分秒
    static func timeStampToHHMMSS(_ timeStamp:String)->String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="HH:mm:ss"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //获取系统的当前时间戳
    static func getStamp()->Int{
        //获取当前时间戳
        let date = Date()
        let timeInterval:Int = Int(date.timeIntervalSince1970)
        return timeInterval
    }
    //月份数字转汉字
    static func numberToChina(monthNum:Int) -> String {
        let ChinaArray = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
        let ChinaStr:String = ChinaArray[monthNum - 1]
        return ChinaStr
        
    }
    //MARK: 数字前补0
    static func add0BeforeNumber(_ number:Int) -> String {
        if number >= 10 {
            return String(number)
        }else{
            return "0" + String(number)
        }
    }
    
    //MARK: 将时间显示为（几分钟前，几小时前，几天前）
    @objc static func compareCurrentTime(str:String) -> String {
        
        let timeDate = self.timeStringToDate(str)
        
        let currentDate = NSDate()
        
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        
        var temp:Double = 0
        
        var result:String = ""
        
        if timeInterval/60 < 1 {
            
            result = "刚刚"
            
        }else if (timeInterval/60) < 60{
            
            temp = timeInterval/60
            
            result = "\(Int(temp))分钟前"
            
        }else if timeInterval/60/60 < 24 {
            
            temp = timeInterval/60/60
            
            result = "\(Int(temp))小时前"
            
        }else if timeInterval/(24 * 60 * 60) < 30 {
            
            temp = timeInterval / (24 * 60 * 60)
            
            result = "\(Int(temp))天前"
            
        }else if timeInterval/(30 * 24 * 60 * 60)  < 12 {
            
            //            temp = timeInterval/(30 * 24 * 60 * 60)
            //
            //            result = "\(Int(temp))个月前"
            result = str;
        }else{
            
            //            temp = timeInterval/(12 * 30 * 24 * 60 * 60)
            //
            //            result = "\(Int(temp))年前"
            result = str;
        }
        
        return result
        
    }
    
    class func updateTimeToCurrennTime(timeStamp: Double) -> String {
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        print(currentTime,   timeStamp, "sdsss")
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp / 1)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        //不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
    
    
}
extension Date {
    //MARK: - 获取日期各种值
    //MARK: 年
    func year() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.year!
    }
    //MARK: 月
    func month() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.month!
        
    }
    //MARK: 日
    func day() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.day!
        
    }
    //MARK: 星期几
    func weekDay()->Int{
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    //MARK: 当月天数
    func countOfDaysInMonth() ->Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return (range?.length)!
        
    }
    //MARK: 当月第一天是星期几
    func firstWeekDay() ->Int {
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
        return firstWeekDay! - 1
        
    }
    //MARK: - 日期的一些比较
    //是否是今天
    func isToday()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    //是否是这个月
    func isThisMonth()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month
    }
    
    static func timeString(timeInterval: TimeInterval) -> String{
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        if date.isToday() {
            //是今天
            formatter.dateFormat = "今天HH:mm"
            return formatter.string(from: date)
            
        }else if date.isYesterday(){
            //是昨天
            formatter.dateFormat = "昨天HH:mm"
            return formatter.string(from: date)
        }else if date.isSameWeek(){
            //是同一周
            let week = date.weekdayStringFromDate()
            formatter.dateFormat = "\(week)HH:mm"
            return formatter.string(from: date)
        }else{
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter.string(from: date)
        }
    }
    func isYesterday() -> Bool {
        let calendar = Calendar.current
        //当前时间
        let nowComponents = calendar.dateComponents([.day], from: Date() )
        //self
        let selfComponents = calendar.dateComponents([.day], from: self as Date)
        let cmps = calendar.dateComponents([.day], from: selfComponents, to: nowComponents)
        return cmps.day == 1
        
    }
    func isSameWeek() -> Bool {
        let calendar = Calendar.current
        //当前时间
        let nowComponents = calendar.dateComponents([.day,.month,.year], from: Date() )
        //self
        let selfComponents = calendar.dateComponents([.weekday,.month,.year], from: self as Date)
        
        return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.weekday == nowComponents.weekday)
    }
    func weekdayStringFromDate() -> String {
        let weekdays:NSArray = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar.init(identifier: .gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: self as Date)
        return weekdays.object(at: theComponents.weekday!) as! String
    }
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
}

