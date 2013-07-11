//
//  VRGViewController.m
//  Vurig Calendar
//
//  Created by in 't Veen Tjeerd on 5/29/12.
//  Copyright (c) 2012 Vurig. All rights reserved.
//

#import "VRGViewController.h"



@interface VRGViewController ()

@end

@implementation VRGViewController

@synthesize navigation;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.frame = CGRectMake(0, 50, ScreenWidth, ScreenHeight);
    calendar.delegate=self;
    [self.view addSubview:calendar];
    
    
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    //NSLog(@"Selected date = %@",date);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *s = [dateFormatter stringFromDate:date];
    
    [self.delegate passValue:s];
    
    [self dismissModalViewControllerAnimated:YES];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)backButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
