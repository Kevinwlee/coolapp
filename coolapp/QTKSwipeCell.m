//
//  QTKSwipeCell.m
//  coolapp
//
//  Created by Kevin Lee on 2/23/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKSwipeCell.h"

@interface QTKSwipeCell()
@property (nonatomic) BOOL supressDeleteButton;
-(UITableView*)getTableView:(UIView*)theView;
@end

@implementation QTKSwipeCell
@synthesize supressDeleteButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.supressDeleteButton = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UITableView*)getTableView:(UIView*)theView {
    if (!theView.superview)
        return nil;
    
    if ([theView.superview isKindOfClass:[UITableView class]])
        return (UITableView*)theView.superview;
    
    return [self getTableView:theView.superview];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // We suppress the Delete button by explicitly not calling
    // super's implementation
    
    if (self.supressDeleteButton)
    {
        // Reset the editing state of the table back to NO
        UITableView* tableView = [self getTableView:self];
        tableView.editing = NO;
    }
    else
        [super setEditing:editing animated:animated];
}


@end
