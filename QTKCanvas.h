//
//  QTKCanvas.h
//  coolapp
//
//  Created by Kevin Lee on 2/20/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioToolbox/AudioToolbox.h"
#import "QTKListViewController.h"
#import "QTKActionTableViewController.h"


@interface QTKCanvas : UIViewController <UITextFieldDelegate> {
    SystemSoundID toneSSIDs[7];
}
@property (retain, nonatomic) QTKListViewController *current;
@property (retain, nonatomic) IBOutlet QTKListViewController *listViewController;
@property (retain, nonatomic) IBOutlet UILabel *textLabel;
@property (retain, nonatomic) IBOutlet QTKListViewController *pingTable;
@property (retain, nonatomic) IBOutlet QTKListViewController *orangeTable;
@property (retain, nonatomic) IBOutlet UITextField *nameField;
@property (retain, nonatomic) IBOutlet UIView *orangeView;
@property (retain, nonatomic) IBOutlet UIView *greenView;
@property (retain, nonatomic) IBOutlet UIView *pingView;
@property (retain, nonatomic) IBOutlet UIView *blueView;
@property (retain, nonatomic) IBOutlet UIView *darkBlueView;
@property (retain, nonatomic) IBOutlet UIView *otherPinkView;
@property (retain, nonatomic) IBOutlet UIView *smallBlueView;
@property (retain, nonatomic) IBOutlet QTKActionTableViewController *leftActionTable;
@property (retain, nonatomic) IBOutlet QTKActionTableViewController *rightActionTable;

- (IBAction)pinkSwipedLeft:(id)sender;
- (IBAction)pinched:(id)sender;
- (IBAction)pinkTapped:(id)sender;
- (IBAction)hold:(id)sender;
- (IBAction)blueTapped:(id)sender;
- (IBAction)darkBlueTapped:(id)sender;
- (IBAction)pinkSwipedRight:(id)sender;
- (IBAction)smallBlueTapped:(id)sender;
- (IBAction)smallGrayTapped:(id)sender;



@end
