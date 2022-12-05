//
//  ViewController.m
//  PinchCanvas
//
//  Created by Jun on 11/27/14.
//  Copyright (c) 2014 Jun Tanaka. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CALayer.h>

//#import "XCDYouTubeKit/XCDYouTubeKit.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (weak, nonatomic) IBOutlet AVPlayerLayer *playerLayer;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text=nil;
    //[self.playerView loadWithVideoId:@"M7lc1UVf-VE"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDataWithNotification:) name:@"DidReceiveDataNotification"
                                               object:nil];
    
}
- (void)didReceiveDataWithNotification:(NSNotification *)notification{
    [self.playerView seekToSeconds:[self.recv_time floatValue] allowSeekAhead:true];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"%@",self.DataInputField.text);
//    self.text = self.DataInputField.text;
    
    
    if (![self.DataInputField.text isEqualToString:@""]){
        if (self.DataInputField.text.length==11 ){
            if(![self.text isEqualToString:self.DataInputField.text] ){
                [self.playerView loadWithVideoId:self.DataInputField.text];
                self.text = self.DataInputField.text;
            }
            if (![self.time isEqualToString:@""]){
                NSLog(@"%@",self.TimeInputField.text);
                self.time = self.TimeInputField.text;
                NSString *message = self.time;
                NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error = nil;
                if ([self.sessionManager.session sendData:data
                                            toPeers:self.sessionManager.session.connectedPeers
                                           withMode:MCSessionSendDataReliable
                                                    error:&error]){
                    self.recv_time=self.time;
                    [self.playerView seekToSeconds:[self.recv_time floatValue] allowSeekAhead:true];
                    NSLog(@"succeed to send data");
                }else{
                    NSLog(@"fail to send data");
                }
            }else{
                self.time = @"0.0";
            }
            return YES;
        }
        
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Try again"
                                                                           message:@"Wrong input url"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
            }];
            [alert addAction:firstAction];
            [self presentViewController:alert animated:YES completion:nil];
            return NO;
        }
    }

    
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.sessionManager startPeerInvitationsWithServiceType:@"pinchcanvas" errorHandler:^(NSError *error) {
        NSLog(@"invitations failed with error %@", error);
    }];
    /*
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"eeSs_WSzK1Y"];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
     */
    
    NSURL *url = [NSURL URLWithString:@"http://www.youtube.com/embed/eeSs_WSzK1Y"];
    //AVPlayer *player = [AVPlayer playerWithURL:url];
    self.player = [AVPlayer playerWithURL:url];
    
    [self.player play];
    //CMTime curtime = [player currentTime];
    //self.player = player;
    //self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:player] ;
    //self.playerLayer.setAffineTransform
    //AVPlayerLayer *avPlayerLayer=[AVPlayerLayer playerLayerWithPlayer:player];
    
    
    //AVPlayerLayer *avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    //self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    //self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //self.playerLayer.frame = self.imageView.bounds;
    
    self.playerView.frame = self.imageView.bounds;
    
    //self.playerLayer.bounds = CGRectMake(0,0,900,750);
    //self.playerLayer.position=CGPointMake(375,375);
    [self.imageView.layer addSublayer:self.playerLayer];
    [self.player play];
    
    
    self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    //int time = (int)(CMTimeGetSeconds(curtime));
    //printf("current time is %i", time);
    
    
    
    /*
    NSURL *url = [NSURL URLWithString:@"http://techslides.com/demos/sample-videos/small.mp4"];
    AVPlayer *player = [AVPlayer playerWithURL:url];

    // create a player view controller
    
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    controller.player = player;
    [player play];
     */
     
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.sessionManager stopPeerInviations];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)updateLabel {
    NSUInteger numberOfConnectedPeers = self.sessionManager.session.connectedPeers.count;
    NSUInteger numberOfConnectedScreens = [SCLScreen mainScreen].connectedScreens.count;
    
    self.textLabel.text = [NSString stringWithFormat:@"%d of %d screens connected", (int)numberOfConnectedScreens, (int)numberOfConnectedPeers];
}

- (void)updateImageFrame {
    CGFloat angle = 0.0;
    CGRect  frame = self.view.bounds;
    //if (self.text!=nil&&self.text.length==11){
        //[self.playerView loadWithVideoId:self.text];
        
        SCLScreen *localScreen = [SCLScreen mainScreen];
        if (localScreen.layout != nil) {
            // align image rotation to the first screen in the layout
            SCLScreen *originScreen = localScreen.layout.screens.firstObject;
            angle = [originScreen convertAngle:0 toCoordinateSpace:self.view];
            
            // extend image frame to the entire bounds of the layout
            frame = [localScreen.layout boundsInScreen:localScreen];
            frame = [localScreen convertRect:frame toCoordinateSpace:self.view];
            
            
        }
    float temps=[self.recv_time floatValue];
    NSLog(@"temps is %f",temps);
        self.playerView.frame =frame;
        self.playerView.transform = CGAffineTransformMakeRotation(angle);
        //[self.playerView seekToSeconds:temps allowSeekAhead:true];
        //[self.playerView currentTime:];
    //}

//
//    [UIView animateWithDuration:0.25 animations:^{
//        self.imageView.transform = CGAffineTransformMakeRotation(angle);
//        self.imageView.frame = frame;
//    }];
    
}

#pragma mark - MCSessionDelegate

// remote peer changed state
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    switch (state) {
        case MCSessionStateNotConnected:
            NSLog(@"peer not connected: %@", peerID);
            break;
        case MCSessionStateConnecting:
            NSLog(@"peer connecting: %@", peerID);
            break;
        case MCSessionStateConnected:
            NSLog(@"peer connected: %@", peerID);
            break;
    }
    
    [self updateLabel];
}

#pragma mark - SCLLayoutObserving

// screen layout changed
- (void)layoutDidChangeForScreens:(NSArray *)updatedScreens {
    NSLog(@"layout changed for screens: %@", updatedScreens);
    
    if ([updatedScreens containsObject:[SCLScreen mainScreen]]) {
        [self updateLabel];
        [self updateImageFrame];
    }
}

@end
