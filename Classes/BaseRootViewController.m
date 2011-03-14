//
//  BaseRootViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 14.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "BaseRootViewController.h"


@implementation BaseRootViewController

@synthesize data           = _data;
//@synthesize tableView      = _tableView;
@synthesize controllerName = _controllerName;
@synthesize detailView     = _detailView;


#pragma mark -
#pragma mark Initialization

-(void)configure
{
}

-(id)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"%s", __func__);
    return [super initWithStyle:UITableViewStylePlain];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewDidAppear:animated];

    // Send notfication to get detail view on screen
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys: self.controllerName, @"controller_name", nil];
    NSNotification *note = [NSNotification notificationWithName:@"new_detail_controller"
                                                         object:self
                                                       userInfo:info];
    [[NSNotificationCenter defaultCenter] postNotification: note];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source


#pragma mark -
#pragma mark Table view delegate


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
    self.data = nil;
    self.controllerName = nil;
    self.detailView = nil;
}

@end
// vim: set sw=4 ts=4 expandtab:

