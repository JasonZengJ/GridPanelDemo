//
//  HomeViewController.swift
//  GridPanelDemo
//
//  Created by jason on 6/19/14.
//  Copyright (c) 2014 jason. All rights reserved.
//

class HomeViewController :UIViewController {
    
    var view1:UIView!
    var view2:UIView!
    var view3:UIView!
    var view4:UIView!
    var view5:UIView!
    var view6:UIView!
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        
        super.init(nibName: nibName, bundle: nibBundle)
        self.view.backgroundColor = UIColor(hex: 0x222222, alpha: 0.9)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        view1 = self.autoLayoutPanelViewWithColor(UIColor(hex: 0xf6b37f, alpha: 1.0), title:"Music", logoImage:UIImage(named: "CD_grid@156px"), backViewBackgroundColor:UIColor(patternImage: UIImage(named: "bg1")), backViewTitle:"Music for better life")
        view2 = self.autoLayoutPanelViewWithColor(UIColor(hex: 0xf9a451, alpha: 1.0), title:"Relax", logoImage:UIImage(named: "coffee_grid@156px"), backViewBackgroundColor:UIColor(patternImage: UIImage(named: "bg2")), backViewTitle:"A cup of coffee for relax")
        view3 = self.autoLayoutPanelViewWithColor(UIColor(hex: 0xf78d60, alpha: 1.0), title:"Message", logoImage:UIImage(named: "message_grid@156px"), backViewBackgroundColor:UIColor(patternImage: UIImage(named: "bg3")), backViewTitle:"From:I have a dream")
        view4 = self.autoLayoutPanelViewWithColor(UIColor(hex: 0xfc7d38, alpha: 1.0), title:"Things", logoImage:UIImage(named: "things_grid@156px"), backViewBackgroundColor:UIColor(patternImage: UIImage(named: "bg4")), backViewTitle:"Do something valuable")
        view5 = self.autoLayoutPanelViewWithColor(UIColor(hex: 0xeb6100, alpha: 1.0), title:"Clock", logoImage:UIImage(named: "clock_grid@156px"), backViewBackgroundColor:UIColor(patternImage: UIImage(named: "bg5")), backViewTitle:"Time can't wait")
        view6 = self.autoLayoutPanelViewWithColor(UIColor(hex: 0xff5e33, alpha: 1.0), title:"Settings", logoImage:UIImage(named: "settings_grid@156px"), backViewBackgroundColor:UIColor(patternImage: UIImage(named: "bg6")), backViewTitle:"Keep in best condition")
        
        self.makeGlobalConstraintsToView(self.view, subviewArray: [view1,view2,view3,view4,view5,view6])
        
    }
    
    
    func autoLayoutPanelViewWithColor(bgColor:UIColor,title:String,logoImage:UIImage,backViewBackgroundColor:UIColor,backViewTitle:String) -> UIView {
        
        var view:PanelView           = PanelView(bgColor: bgColor)
        view.backViewTitle           = backViewTitle
        view.backViewBackgroundColor = backViewBackgroundColor
        self.imageViewWithImage(logoImage, title: title, inPanelView: view)
        self.addFlipTapGestureRecognizerToView(view)
        self.view.addSubview(view)
        
        return view
        
    }
    
    func addFlipTapGestureRecognizerToView(view:UIView) {
        
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "flipView:")
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
    }
    
    func makeGlobalConstraintsToView(view:UIView,subviewArray:Array<AnyObject>) {
        
        var dic:NSDictionary = [
            "view1":subviewArray[0],
            "view2":subviewArray[1],
            "view3":subviewArray[2],
            "view4":subviewArray[3],
            "view5":subviewArray[4],
            "view6":subviewArray[5]
        ];
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view5][view6(==view5)]|",
                                                                        options: NSLayoutFormatOptions.AlignAllBaseline,
                                                                        metrics: nil,
                                                                          views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view3][view4(==view3)]|",
                                                                        options: NSLayoutFormatOptions.AlignAllBaseline,
                                                                        metrics: nil,
                                                                          views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view1][view2(==view1)]|",
                                                                        options: NSLayoutFormatOptions.AlignAllBaseline,
                                                                        metrics: nil,
                                                                          views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-22-[view1][view3(==view1)][view5(==view1)]|",
                                                                        options: nil,
                                                                        metrics: nil,
                                                                          views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-22-[view2][view4(==view2)][view6(==view2)]|",
                                                                        options: nil,
                                                                        metrics: nil,
                                                                          views: dic))
        
    }
    
    func flipView(sender:UITapGestureRecognizer) {
        
        var flipDuration = 0.8
        UIView.transitionWithView(sender.view,
            duration: flipDuration,
            options: UIViewAnimationOptions.TransitionFlipFromLeft,
            animations: {() -> Void in
            
            },
            completion: {(finished:Bool) -> Void in
        
            }
        )
        dispatch_after(dispatch_time_t(flipDuration / 2) * 1000, dispatch_get_main_queue(), { () -> Void in
            (sender.view as PanelView).changeView()
            println("here");
        })
        
    }
    
    func imageViewWithImage(image:UIImage,title:String,inPanelView:UIView) {
        
        var panelLogo       = UIImageView(image: image)
        var label           = UILabel(frame: CGRectMake(0, 70, 75, 40))
        label.textColor     = UIColor.whiteColor();
        label.text          = title
        label.textAlignment = NSTextAlignment.Center
        
        panelLogo.setTranslatesAutoresizingMaskIntoConstraints(false)
        panelLogo.addSubview(label)
        inPanelView.addSubview(panelLogo)
        inPanelView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-45-[panelLogo]-45-|",
                                                                          options: NSLayoutFormatOptions.AlignAllBaseline,
                                                                          metrics: nil,
                                                                            views: ["panelLogo":panelLogo]))
        inPanelView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[panelLogo]-60-|",
                                                                          options: NSLayoutFormatOptions.AlignAllBaseline,
                                                                          metrics: nil,
                                                                            views: ["panelLogo":panelLogo]))
        
    }
    
    
}