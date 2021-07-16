//
//  daoyu.swift
//  daoyu
//
//  Created by 甘世清 on 2021/6/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    //提供一个默认的视图，当网络数据请求失败或者其他一些异常的时候，用于展示
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
   //截图
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
   //在这个方法内可以进行网络请求，拿到的数据保存在对应的entry中，调用completion之后会到刷新小组件
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct daoyuEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
           
    }
}
//入口

@main

struct daoyu: Widget {
    let kind: String = "岛屿"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            daoyuEntryView(entry: entry)
        }
        //添加编辑界面展示的标题
        .configurationDisplayName(kind)
        //添加编辑界面展示的描述内容
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
        
        
    }
}
struct PoetryWidgetView:View {
//    let entry: PoetryEntry
    var body: some View {
        VStack(alignment: .leading, spacing: 4)
            {
            
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: 20, minHeight: 0, idealHeight: 0, maxHeight: 10, alignment: .leading)
    }
    
    
}


struct daoyu_Previews: PreviewProvider {
    static var previews: some View {
        daoyuEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

struct Poetry {
    let content: String
    let origin: String
    let author: String
    
    
}
//网络请求
struct PoetryRequest {
    static func request(completion:@escaping (Result<Poetry,Error>) -> Void){
        let url = URL(string: "https://v1.alapi.cn/api/shici?type=shuqing")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error)  in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            let poetry = poeryFromjson(fromData: data!)
            completion(.success(poetry))
        }
        task.resume()
        
    }
    static func poeryFromjson(fromData data: Data)-> Poetry{
        let json  = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
//        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        //因为免费接口请求频率问题，如果太频繁了，请求可能失败，这里做下处理，放置crash
        guard let data = json["data"] as? [String: Any] else {
            return Poetry(content: "诗词加载失败，请稍微再试！", origin: "耐依福", author: "佚名")
        }
        let content = data["content"] as! String
        let origin = data["prigin"] as! String
        let author = data["auther"] as! String
        
        return Poetry(content: content, origin: origin, author: author)
 
        
    }
}
