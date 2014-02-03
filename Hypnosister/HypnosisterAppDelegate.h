//
//  HypnosisterAppDelegate.h
//  Hypnosister
//
//  Created by Rachel Johnson on 2/1/14.
//  Copyright (c) 2014 Rachel Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HypnosisView.h"

@interface HypnosisterAppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate>
{
    HypnosisView *view;
}
@property (strong, nonatomic) UIWindow *window;

@end
