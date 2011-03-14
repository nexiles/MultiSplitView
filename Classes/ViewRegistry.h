//
//  ViewRegistry.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//@protocol ConfigurableViewController <NSObject>

//-(void)configure:(NSDictionary *)info;

//@end
//


@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
}
-(void)configure;
@property (nonatomic,retain) NSDictionary *data;
@end

@interface RootViewController : UIViewController {
}
@property (nonatomic, retain) DetailViewController *detailView;
@property (nonatomic,retain) NSDictionary *data;
-(void)configure;
@end

@interface ViewRegistry : NSObject {
	NSMutableDictionary *_registry;
}

@property (readonly) NSMutableDictionary *registry;

+(ViewRegistry *)sharedViewRegistry;

// Single Controllers
-(void)registerViewController:(UIViewController *)controller forName:(NSString *)name;
-(UIViewController *)controllerForName:(NSString *)name;

// Root/Detail VCs
- (void)registerRootController:(RootViewController *)controller forName:(NSString *)name;
- (void)registerDetailController:(DetailViewController *)controller forName:(NSString *)name;

-(RootViewController *)rootControllerForName:(NSString *)name;
-(DetailViewController *)detailControllerForName:(NSString *)name;

@end

// vim: set ts=2 sw=2 expandtab:
