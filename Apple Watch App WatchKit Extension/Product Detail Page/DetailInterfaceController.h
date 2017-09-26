//
//  DetailInterfaceController.h
//  iWatchPOC
//
//  Created by annapurna chandra on 28/04/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//


#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@protocol DetailInterfaceControllerDelegate

-(void)updateCountData:(NSDictionary *)dataDictionary;

@end

@interface DetailInterfaceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;

@property(nonatomic, weak)IBOutlet WKInterfaceButton *addButton;
@property(nonatomic, weak)IBOutlet WKInterfaceButton *substractButton;
@property(nonatomic, weak)IBOutlet WKInterfaceButton *saveButton;
@property(nonatomic, weak)IBOutlet WKInterfaceLabel  *resultLabel;
@property(nonatomic, weak)IBOutlet WKInterfaceLabel  *titleLabel;
@property(nonatomic, weak) id<DetailInterfaceControllerDelegate> delegate;

-(IBAction)addButtonAction:(id)sender;
-(IBAction)substractButtonAction:(id)sender;
-(IBAction)saveButtonAction:(id)sender;

@end
