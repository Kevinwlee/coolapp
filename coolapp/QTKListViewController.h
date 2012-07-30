//
//  QTKListViewController.h
//  coolapp
//
//  Created by Kevin Lee on 2/20/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTKListViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *items;
- (IBAction)pinched:(id)sender;

@end
