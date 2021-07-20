//
//  UILabel+Extension.swift
//  demo
//
//  Created by 甘世清 on 2021/7/19.
//


import UIKit

let lineSpaceKey = "lineSpaceKey"

extension UILabel {
    var lineSpace :CGFloat?{
        set{
            objc_setAssociatedObject(self, lineSpaceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return (objc_getAssociatedObject(self, lineSpaceKey) as? CGFloat)
        }
    }
    
    //label 内容行数 size是指label的宽和高 linespace是行间距
    
    func textLineNums(size:CGSize) ->  CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = self.lineBreakMode
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineSpacing = (lineSpace != nil) ? lineSpace!:10
        paragraphStyle.lineSpacing = paragraphStyle.lineSpacing - (self.font.lineHeight - self.font.pointSize)
        let  attributes = [NSAttributedString.Key.font : self.font,NSAttributedString.Key.paragraphStyle : paragraphStyle];
        let contentSize = self.text!.boundingRect(with: size, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: attributes as [NSAttributedString.Key : Any], context: nil).size
        let lineNumber = ceil(contentSize.height / self.font.lineHeight)
        
        return lineNumber
    }
    
    
    static func heightForView(text:String, font:UIFont,width:CGFloat,numberOfLines:Int,lineSpace:CGFloat = 10)-> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        //通过富文本设置行间距
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpace
        paraph.lineSpacing = paraph.lineSpacing - (font.lineHeight - font.pointSize)
        
        let tempMutableString = NSMutableAttributedString(string: text,attributes: [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle:paraph])
        //添加不同字体大小
        label.attributedText = NSAttributedString(attributedString: tempMutableString)
        
        label.sizeToFit()
        return label.frame.height
    }
    
    static func widthForView(text:String, font:UIFont, height:CGFloat) ->CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        let tempMutableString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:font])
        label.attributedText = NSAttributedString(attributedString: tempMutableString)
        label.sizeToFit()
        return label.frame.width
    }
    
    public static func lines(text:String, font:UIFont, width:CGFloat,lineSpace:CGFloat = 1) ->Int  {
        let requiredHeight = UILabel.heightForView(text: text, font: font, width: width, numberOfLines: 0, lineSpace: lineSpace)
        
        return Int(requiredHeight / font.lineHeight)
    }
    
    public func getLinesArrayOfStringWidth(_ width:CGFloat)->[String]? {
        guard let str = text,str.isEmpty == false, let font = font else {
            return nil
        }
        var linesArr = [String]()
        let myFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: str)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byCharWrapping
        
        attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, str.count))
        attStr.addAttribute(NSAttributedString.Key(kCTFontAttributeName as String), value: myFont, range: NSMakeRange(0, str.count))
        
        let frameSetter = CTFramesetterCreateWithAttributedString(attStr)
        let  path = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: width, height: 10000))
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        if let lines  = CTFrameGetLines(frame) as? [CTLine] {
            lines.forEach { (line: CTLine) in
                let lineRange = CTLineGetStringRange(line)
                let lineStr = (str as NSString).substring(with: NSMakeRange(lineRange.location, lineRange.length))
                
                CFAttributedStringSetAttribute(attStr, lineRange, kCTKernAttributeName, NSNumber(value: 0) as CFTypeRef)
                CFAttributedStringSetAttribute(attStr, lineRange, kCTKernAttributeName, NSNumber(value: 0) as CFTypeRef)
                linesArr.append(lineStr)
            }
        }
        
        return linesArr
    }
    public func setAttText(text:String,font:UIFont,fontColor:UIColor) {
        let tempString = text
        let tempMutableString = NSMutableAttributedString(string: tempString, attributes: [NSAttributedString.Key.font:font,NSAttributedString.Key.foregroundColor:fontColor])
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = (lineSpace != nil) ? lineSpace! : 10
        paraph.lineSpacing = paraph.lineSpacing - (self.font.lineHeight - self.font.pointSize)
        paraph.lineBreakMode = .byTruncatingTail
        
        tempMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paraph, range: NSRange(location: 0, length: tempString.Length))
        
        let labelText = NSAttributedString(attributedString: tempMutableString)
        attributedText = labelText
        
    }
    
    public func setAttText(text:String) {
        let tempString = text
        let selffont = font != nil ? font! : HLFont(14)
        let selftextColor  = textColor != nil ? textColor! : MTTextColorBlack
        
        let tempMurableString = NSMutableAttributedString(string: tempString, attributes: [NSAttributedString.Key.font:selffont,NSAttributedString.Key.foregroundColor:selftextColor])
        
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 10
        paraph.lineSpacing = paraph.lineSpacing - (self.font.lineHeight - self.font.pointSize)
        paraph.lineBreakMode = .byTruncatingTail
        tempMurableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paraph, range: NSRange(location: 0, length: tempString.Length))
        let labelText = NSAttributedString(attributedString: tempMurableString)
        
        attributedText = labelText
        
    }
    
}
extension UILabel {

    /// 设置颜色 字体大小
    /// - Parameters:
    ///   - textColor: 字体颜色
    ///   - fontSize: 字体大小
    
    public final func extSetTextColor(_ textColor : UIColor, fontSize : CGFloat){
        
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    public final func extSetTextColor(_ textColor : UIColor ,
                                      fontSize : CGFloat ,
                                      textAlignment : NSTextAlignment ,
                                      isBold : Bool = false,
                                      numberOfLKines : Int = 1){
        self.textColor = textColor
        if isBold {
            self.font = UIFont.boldSystemFont(ofSize: fontSize)
        }else{
            self.font = UIFont.systemFont(ofSize: fontSize)
        }
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
    
    
    /// 设置颜色,字体大小
    /// - Parameters:
    ///   - text: 内容
    ///   - textColor: 字体颜色
    ///   - fontSize: 字体大小
    public final func extSetText(_ text : String ,
                                 textColor : UIColor,
                                 fontSize : CGFloat){
        self.extSetTextColor(textColor, fontSize: fontSize)
        self.text = text;
    }
    
    
    /// 设置颜色, 字体,对齐方式
    /// - Parameters:
    ///   - text: 内容
    ///   - textColor: 颜色
    ///   - fontSize: 字体
    ///   - textAlignment: 对齐方式
    public final func extSetText(_ text : String ,
                                 textColor : UIColor ,
                                 fontSize : CGFloat,
                                 textAlignment : NSTextAlignment){
        self.extSetText(text, textColor: textColor, fontSize: fontSize)
        self.textAlignment = textAlignment
    }
    
    public var attributedLabelFrame : CGRect {
        get{
            guard let attributedText = self.attributedText else {
                return .zero
            }
            return attributedText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.frame.height), options: .usesLineFragmentOrigin, context: nil)
        }
    }
    
}



extension UILabel {
    //判断文本标签的内容是否被截断
    var isTruncated : Bool{
        guard let labelText = text else{
            return false
        }
        //理论尺寸
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        
        let labelTextSize = (labelText as NSString).boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:self.font ?? UIFont()], context: nil)
        //理论行数
        let labelTextLines  = Int(ceil(CGFloat(labelTextSize.height) / self.font.lineHeight))
        //实际行数
        var labelShowLines = Int(floor(CGFloat(bounds.size.height) / self.font.lineHeight))
        if self.numberOfLines != 0 {
            labelShowLines = min(labelShowLines, self.numberOfLines)
        }
        return labelTextLines > labelShowLines
    }
    
}

extension UILabel {
    
    /// 设置颜色 大小
    /// - Parameters:
    ///   - textColor: 颜色
    ///   - font: 大小
    public final func extSetTextColor(_ textColor : UIColor, font : UIFont){
        self.textColor = textColor
        self.font = font
    }
    
    /**
     设置内容 颜色 字体大小
     
     - parameter text:      内容
     - parameter textColor: 字体颜色
     - parameter font:  字体Font
     */
    public final func extSetText(_ text : String , textColor : UIColor , font : UIFont){
        
        self.extSetTextColor(textColor, font: font)
        self.text = text;
        
    }
    
    /**
     设置内容 颜色 字体大小 对齐方式
     
     - parameter text:      内容
     - parameter textColor: 字体颜色
     - parameter font:  字体Font
     - parameter textAlignment:  对齐方式
     */
    public final func extSetText(_ text : String ,
                                 textColor : UIColor ,
                                 font : UIFont ,
                                 textAlignment : NSTextAlignment){
        self.extSetText(text, textColor: textColor, font: font)
        self.textAlignment = textAlignment
    }
}
