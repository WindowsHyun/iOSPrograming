//
//  ViewController.swift
//  XMLParsingDemo
//
//  Created by kpugame on 2016. 5. 17..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {
    
    @IBOutlet weak var tbData: UITableView!
    // xml 파일을 다운로드 및 파싱하는 오브젝트
    var parser = NSXMLParser()
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    // title과 date 같은 feed데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL: (NSURL(string:"http://images.apple.com/main/rss/hotnews/hotnews.rss"))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    func parser(parser:NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        element = elementName
        if(elementName as NSString).isEqualToString("item") // element 가 item이면 아래를 실행
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
    if element.isEqualToString("title")
    {
    title1.appendString(string)
    } else if element.isEqualToString("pubDate")
    {
    date.appendString(string)
    }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!,namespaceURI: String!, qualifiedName qName: String!)
    {
        if(elementName as NSString).isEqualToString("item")
        {
            if !title1.isEqual(nil)
            {
                elements.setObject(title1, forKey: "title")
            }
            if !date.isEqual(nil)
            {
                elements.setObject(date, forKey: "date")
            }
            posts.addObject(elements)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        if(cell.isEqual(NSNull))
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! UITableViewCell;
            
        }
        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        cell.detailTextLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("date") as! NSString as String
        
        return cell as UITableViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    
}