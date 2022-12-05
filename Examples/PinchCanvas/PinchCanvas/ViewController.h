//
//  ViewController.h
//  PinchCanvas
//
//  Created by Jun on 11/27/14.
//  Copyright (c) 2014 Jun Tanaka. All rights reserved.
//
#import <AVKit/AVKit.h>
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CALayer.h>
#import "YTPlayerView.h"

@import ScreenLayout;

@interface ViewController : SCLPinchViewController
@property (nonatomic) AVPlayer * player;
@property (nonatomic) AVPlayerLayer *playerLayer;
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UITextField *DataInputField;
@property (weak, nonatomic) IBOutlet UITextField *TimeInputField;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *time;

@end
