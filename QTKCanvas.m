//
//  QTKCanvas.m
//  coolapp
//
//  Created by Kevin Lee on 2/20/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKCanvas.h"
#import <QuartzCore/QuartzCore.h>

@implementation QTKCanvas

@synthesize listViewController;
@synthesize textLabel;
@synthesize pingTable;
@synthesize orangeTable;
@synthesize current;
@synthesize nameField;
@synthesize orangeView;
@synthesize greenView;
@synthesize pingView;
@synthesize blueView;
@synthesize darkBlueView;
@synthesize otherPinkView;
@synthesize smallBlueView;
@synthesize leftActionTable;
@synthesize rightActionTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)playSoundAtIndex:(int)toneIndex {
    SystemSoundID toneSSID = toneSSIDs[toneIndex];
    AudioServicesPlaySystemSound(toneSSID);
}

- (void)rightToLeft:(NSNotification *)notification{
    QTKActionTableViewController *notificationTable = [notification.userInfo objectForKey:@"tableView"];
    if (self.rightActionTable == notificationTable) {
        [self playSoundAtIndex:4];
        [self.leftActionTable.tableView beginUpdates];
        [self.leftActionTable.items insertObject:notification.object atIndex:0];
        [self.leftActionTable.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.leftActionTable.tableView endUpdates];            
    }
}

- (void)leftToRight:(NSNotification *)notification{
    QTKActionTableViewController *notificationTable = [notification.userInfo objectForKey:@"tableView"];
    if (self.leftActionTable == notificationTable) {
        [self playSoundAtIndex:5];
        [self.rightActionTable.tableView beginUpdates];
        [self.rightActionTable.items insertObject:notification.object atIndex:0];
        [self.rightActionTable.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.rightActionTable.tableView endUpdates];            
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect startingRect = CGRectMake(256, 1000, 320, 200);
    self.listViewController.view.frame = startingRect;
    [self.view addSubview:self.listViewController.view];
    
    self.pingTable.view.frame = startingRect;
    [self.view addSubview:self.pingTable.view];
    
    self.orangeTable.view.frame = startingRect;
    [self.view addSubview:self.orangeTable.view];
    
    self.rightActionTable.view.frame = startingRect;
    [self.view addSubview:self.rightActionTable.view];
    
    self.leftActionTable.view.frame = startingRect;
    [self.view addSubview:self.leftActionTable.view];
    
    for(int count = 0; count < 7; count++){
        NSString *toneFilename = [NSString stringWithFormat:@"dong%d", count];    
        NSURL *toneURLRef = [[NSBundle mainBundle] URLForResource:toneFilename
                                                    withExtension:@"wav"];
        SystemSoundID toneSSID = 0;
        AudioServicesCreateSystemSoundID((CFURLRef) toneURLRef, &toneSSID);
        toneSSIDs[count] = toneSSID;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rightToLeft:) name:@"swipe_left" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftToRight:) name:@"swipe_right" object:nil];

}

- (void)viewDidUnload
{
    [self setTextLabel:nil];

    [self.listViewController.view removeFromSuperview];    
    [self setListViewController:nil];

    [self setPingTable:nil];
    [self setOrangeTable:nil];

    [self setNameField:nil];
    [self setOrangeView:nil];
    [self setGreenView:nil];
    [self setPingView:nil];
    [self setBlueView:nil];
    [self setDarkBlueView:nil];
    
    [self setOtherPinkView:nil];
    [self setSmallBlueView:nil];
    [self setLeftActionTable:nil];
    [self setRightActionTable:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.nameField.hidden) {
            [self.view endEditing:YES];
            [self playSoundAtIndex:2];
            self.nameField.hidden = YES;
    }
}

- (void)animate{
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.textLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 delay:1.25 options:UIViewAnimationCurveEaseInOut animations:^{
            self.textLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.textLabel.text = @"";
            self.textLabel.textColor = [UIColor whiteColor];

        }];
        
    }];
}

- (void) cleanUpGreenTable {
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationCurveEaseIn animations:^{
        self.listViewController.view.frame =  CGRectMake(self.listViewController.view.frame.origin.x, 1000, 320, 748);
    } completion:^(BOOL finished) {

    }]; 
}
- (void) cleanUpOrangeTable {
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationCurveEaseIn animations:^{
        self.orangeTable.view.frame =  CGRectMake(self.orangeTable.view.frame.origin.x, 1000, 320, 748);
    } completion:^(BOOL finished) {

    }]; 
}
- (void) cleanUpPingTable {
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationCurveEaseIn animations:^{
        self.pingTable.view.frame =  CGRectMake(self.pingTable.view.frame.origin.x, 1000, 320, 748);
    } completion:^(BOOL finished) {

    }]; 
}


- (void)highlightView:(CGRect)frame {
    UIView *hi = [[UIView alloc] initWithFrame:frame];
    hi.opaque = NO;
    hi.alpha = .0;
    hi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:hi];
    [hi release];
    [UIView animateWithDuration:.1 animations:^{
        hi.alpha = .5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            hi.alpha = .0;    
        } completion:^(BOOL finished) {
            [hi removeFromSuperview];    
        }];
    }];

}

- (IBAction)pinkSwipedLeft:(id)sender {
    NSLog(@"Pink swiped");
    UIView *myView = self.otherPinkView;
    CALayer *layer = myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 75.0f * M_PI / -180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}

- (IBAction)pinched:(id)sender {
    [self playSoundAtIndex:0];
    [self highlightView:self.greenView.frame];
    self.textLabel.text = @"Green!!!";
    self.textLabel.textColor = [UIColor greenColor];
    [self animate];
    [self cleanUpPingTable];
    [self cleanUpOrangeTable];

    self.current = self.listViewController;
    [UIView animateWithDuration:.2 animations:^{
        self.listViewController.view.frame = CGRectMake(256, 0, 320, 748);    
    }];
}

- (IBAction)hold:(id)sender {
    [self playSoundAtIndex:1];
    [self highlightView:self.orangeView.frame];

    self.textLabel.text = @"Orange!!!";
    self.textLabel.textColor = [UIColor orangeColor];
    [self animate];
    [self cleanUpGreenTable];
    [self cleanUpPingTable];
    
    self.current = self.orangeTable;
    [UIView animateWithDuration:.2 animations:^{
        self.orangeTable.view.frame = CGRectMake(256, 0, 320, 748);    
        
    }];

}

- (IBAction)pinkTapped:(id)sender {
    [self playSoundAtIndex:2];
    [self highlightView:self.pingView.frame];
    self.textLabel.text = @"Pink!!!";
    self.textLabel.textColor = [UIColor magentaColor];
    [self animate];
    [self cleanUpGreenTable];
    [self cleanUpOrangeTable];
    self.current = self.pingTable;
    [UIView animateWithDuration:.2 animations:^{
        self.pingTable.view.frame = CGRectMake(256, 0, 320, 748);    
    }];
    
}

- (IBAction)blueTapped:(id)sender {
    [self highlightView:self.blueView.frame];
    if (self.nameField.hidden) {
        [self.nameField becomeFirstResponder];
        self.nameField.hidden = NO;
    } else {
        [self.nameField resignFirstResponder];
        self.nameField.hidden = YES;
    }
    
    [self playSoundAtIndex:3];
}

- (IBAction)darkBlueTapped:(id)sender {
    [self highlightView:self.darkBlueView.frame];
    if (self.current.tableView.editing) {
        [self playSoundAtIndex:4];
    } else {
        [self playSoundAtIndex:5];
    }
    [self.current.tableView setEditing:!self.current.tableView.editing animated:YES];
}

- (IBAction)pinkSwipedRight:(id)sender {
    NSLog(@"Pink swiped");
    UIView *myView = self.otherPinkView;
    CALayer *layer = myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 75.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;

}
- (void)moveLeft:(UIView *)aView{
    CGRect newRect = aView.frame;
    newRect.origin.x += -254;
    aView.frame = newRect;
}
- (void)moveRight:(UIView *)aView {
    CGRect newRect = aView.frame;
    newRect.origin.x += 254;
    aView.frame = newRect;
}

- (IBAction)smallBlueTapped:(id)sender {
    [self playSoundAtIndex:0];
    [self cleanUpPingTable];
    [self cleanUpOrangeTable];
    [self cleanUpGreenTable];
    
    [UIView animateWithDuration:.25 animations:^{
        [self moveLeft:self.greenView];
        [self moveLeft:self.orangeView];
        [self moveLeft:self.pingView];
        
        [self moveRight:self.blueView];
        [self moveRight:self.darkBlueView];
        
    } completion:^(BOOL finished) {

    }];
    [UIView animateWithDuration:.2 animations:^{
        self.leftActionTable.view.frame = CGRectMake(10, 10, 320, 738);    
        self.rightActionTable.view.frame = CGRectMake(350, 10, 320, 738);    
    }];

}

- (IBAction)smallGrayTapped:(id)sender {
    [self playSoundAtIndex:1];
    
    [UIView animateWithDuration:.25 animations:^{
        [self moveRight:self.greenView];
        [self moveRight:self.orangeView];
        [self moveRight:self.pingView];
        
        [self moveLeft:self.blueView];
        [self moveLeft:self.darkBlueView];
        
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:.2 animations:^{
        CGRect startingRect = CGRectMake(256, 1000, 320, 200);
        self.leftActionTable.view.frame = startingRect;
        self.rightActionTable.view.frame = startingRect;
    }];


}

- (void)dealloc {
    [textLabel release];
    
    [listViewController release];
    [pingTable release];
    [orangeTable release];

    [nameField release];
    [orangeView release];
    [greenView release];
    [pingView release];
    [blueView release];
    [darkBlueView release];

    [otherPinkView release];
    [smallBlueView release];
    [leftActionTable release];
    [rightActionTable release];
    [super dealloc];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self playSoundAtIndex:5];
    UILabel *animationLabel = [[UILabel alloc] initWithFrame:self.nameField.frame];
    animationLabel.text = self.nameField.text;
    [self.view addSubview:animationLabel];
    [animationLabel release];
    
    [self.current.tableView beginUpdates];
    [self.current.items insertObject:@"" atIndex:0];
    [self.current.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.current.tableView endUpdates];
    
    [UIView animateWithDuration:.25 animations:^{
        CGRect finalRect = [self.current.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        finalRect.origin.x = 256;
        animationLabel.frame = finalRect;
        
    } completion:^(BOOL finished) {
        [animationLabel removeFromSuperview];
        [self.current.tableView beginUpdates];
        [self.current.items replaceObjectAtIndex:0 withObject:self.nameField.text];
        [self.current.tableView reloadRowsAtIndexPaths:[self.current.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
        [self.current.tableView endUpdates];
         self.nameField.text = @"";        
    }];
     return YES;
}
@end
