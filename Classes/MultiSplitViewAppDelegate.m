//
//  MultiSplitViewAppDelegate.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "MultiSplitViewAppDelegate.h"

#import "ASIHTTPRequest.h"
#import "ViewRegistry.h"
#import "NXDataLoader.h"
#import "NXWindchillDataLoader.h"

#import "OrgDetailViewController.h"
#import "OrgRootViewController.h"
#import "ProductDetailViewController.h"
#import "ProductRootViewController.h"
#import "DocumentDetailViewController.h"
#import "DocumentRootViewController.h"

@interface MultiSplitViewAppDelegate ()
-(void)configureRootViews;
-(void)newRootController:(NSNotification *)note;
-(void)newDetailController:(NSNotification *)note;
@end

@implementation MultiSplitViewAppDelegate

@synthesize window, splitViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSLog(@"%s", __func__);

  ViewRegistry *registry = [ViewRegistry sharedViewRegistry];

  [registry registerRootController:[[OrgRootViewController alloc] initWithNibName:@"OrgRootViewController" bundle:nil]
                           forName:@"organization"];
  [registry registerDetailController:[[OrgDetailViewController alloc] initWithNibName:@"OrgDetailViewController" bundle:nil]
                           forName:@"organization"];

  [registry registerRootController:[[ProductRootViewController alloc] initWithNibName:@"ProductRootViewController" bundle:nil]
                           forName:@"product"];
  [registry registerDetailController:[[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil]
                           forName:@"product"];

  [registry registerRootController:[[ProductRootViewController alloc] initWithNibName:@"DocumentRootViewController" bundle:nil]
                           forName:@"document"];
  [registry registerDetailController:[[ProductDetailViewController alloc] initWithNibName:@"DocumentDetailViewController" bundle:nil]
                           forName:@"document"];

  [self configureRootViews];

  NSLog(@"%s: self.splitViewController.viewControllers=%@", __func__, self.splitViewController.viewControllers);
  NSLog(@"%s: self.splitViewController.viewControllers 0=%@", __func__, [[self.splitViewController.viewControllers objectAtIndex:0] viewControllers]);
  NSLog(@"%s: self.splitViewController.viewControllers 1=%@", __func__, [self.splitViewController.viewControllers objectAtIndex:1]);

  // Register for "push" View Controller notifications
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self selector:@selector(newRootController:) name:@"new_root_controller" object:nil];
  [nc addObserver:self selector:@selector(newDetailController:) name:@"new_detail_controller" object:nil];



  /// test the NXWindchillDataLoader
  NXWindchillDataLoader *dataLoader = [NXWindchillDataLoader sharedLoader];

  dataLoader.baseURL = @"http://wc.nexiles.com/Windchill/netmarkets/jsp/nexiles";
  dataLoader.username = @"wcadmin";
  dataLoader.password = @"wcadmin";


  [dataLoader getOrganizationsWithSuccess:
    ^(NSDictionary *data){
            NSLog(@"%s: data=%@", __func__, data);

        }
                                  failure:
    ^(ASIHTTPRequest *request){
            NSLog(@"%s: error=%@", __func__, request.error);

        }];

  [dataLoader getProductsForOrganization:@"OR:wt.pdmlink.PDMLinkProduct:35696"
                                 success:^(NSDictionary *data){
            NSLog(@"%s: data=%@", __func__, data);

        }
                                  failure:^(ASIHTTPRequest *request){
            NSLog(@"%s: error=%@", __func__, request.error);

        }];

  [dataLoader getDocumentInfoForOID:@"OR:wt.epm.EPMDocument:46499"
                            success:^(NSDictionary *data){
            NSLog(@"%s: data=%@", __func__, data);

        }
                            failure:^(ASIHTTPRequest *request){
            NSLog(@"%s: error=%@", __func__, request.error);

        }];

  // Add the split view controller's view to the window and display.
  [self.window addSubview:splitViewController.view];
  [self.window makeKeyAndVisible];
  return YES;
}

#pragma mark -
#pragma mark Split View Controller handling

-(void)newRootController:(NSNotification *)note
{
  NSLog(@"%s: note=%@", __func__, note);

  NSDictionary *info = [note userInfo];

  NSString *controller_name = [info objectForKey:@"controller_name"];
  NSDictionary *data        = [info objectForKey:@"data"];

  // fetch VCs from registry
  ViewRegistry *registry         = [ViewRegistry sharedViewRegistry];
  BaseRootViewController *rootVC     = [registry rootControllerForName:controller_name];
  BaseDetailViewController *detailVC = [registry detailControllerForName:controller_name];
  BaseRootViewController *topVC      = (BaseRootViewController *)[[self.splitViewController.viewControllers objectAtIndex:0] topViewController];

  NSLog(@"%s: rootVC=%@", __func__, rootVC);
  NSLog(@"%s: topVC=%@", __func__, topVC);
  // we don't want to push the same instance twice.
  if (rootVC != topVC) {
    // hook them
    rootVC.detailView = detailVC;
    self.splitViewController.delegate = detailVC;

    // configure with data
    rootVC.data = data;

    // configure SplitController's UINavigationController
    [[self.splitViewController.viewControllers objectAtIndex:0] pushViewController:rootVC animated:YES];
  }
}

-(void)newDetailController:(NSNotification *)note
{
  NSLog(@"%s: note=%@", __func__, note);

  NSDictionary *info = [note userInfo];

  NSString *controller_name = [info objectForKey:@"controller_name"];

  ViewRegistry *registry         = [ViewRegistry sharedViewRegistry];
  BaseDetailViewController *detailVC = [registry detailControllerForName:controller_name];
  BaseDetailViewController *topVC = (BaseDetailViewController *)[[self.splitViewController.viewControllers objectAtIndex:1] topViewController];

  NSLog(@"%s: detailVC=%@", __func__, detailVC);
  NSLog(@"%s: topVC=%@", __func__, topVC);

  // we don't want to push the same instance twice.
  if (detailVC != topVC) {
    self.splitViewController.delegate = detailVC;


    [[self.splitViewController.viewControllers objectAtIndex:1] pushViewController:detailVC animated:YES];
  }
}

#pragma mark -
#pragma mark Configure SplitController

-(void)configureRootViews
{
  NSLog(@"%s", __func__);
  ViewRegistry *registry = [ViewRegistry sharedViewRegistry];

  BaseRootViewController *rootVC = [registry rootControllerForName:@"organization"];
  BaseDetailViewController *detailVC = [registry detailControllerForName:@"organization"];

  // hook view controllers
  rootVC.detailView = detailVC;

  // Configure Split view with an UINavigationController and a detail view
  self.splitViewController = [[[UISplitViewController alloc] init] autorelease];
  UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:rootVC];
  UINavigationController *detail = [[UINavigationController alloc] initWithRootViewController:detailVC];

  [detail setNavigationBarHidden:YES animated:NO];

  NSArray *viewControllers = [NSArray arrayWithObjects: root, detail, nil];


  self.splitViewController.viewControllers = viewControllers;
  self.splitViewController.delegate = detailVC;

  [root release];
  [detail release];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];

  [splitViewController release];
  [window release];
  [super dealloc];
}

@end
// vim: set ts=2 sw=2 expandtab:

