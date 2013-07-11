//
//  VRGViewController.h
//  Vurig Calendar
//
//  Created by in 't Veen Tjeerd on 5/29/12.
//  Copyright (c) 2012 Vurig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"
#import "PassValueDelegate.h"

@interface VRGViewController : UIViewController <VRGCalendarViewDelegate>


@property (retain,nonatomic) IBOutlet UINavigationBar *navigation;

//这里用assign而不用retain是为了防止引起循环引用。
@property(nonatomic,assign) NSObject<PassValueDelegate> *delegate;

- (IBAction)backButton:(id)sender;

@end
