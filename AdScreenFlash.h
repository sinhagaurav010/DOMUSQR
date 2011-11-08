//
//  AdScreenFlash.h
//  daqri
//
//  Created by gaurav on 19/06/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ADScreenFlashDelegate <NSObject>
- (void) removeViewFlash;  //Required Protocol
@end

@interface AdScreenFlash : UIView {
    id <ADScreenFlashDelegate> delegate;
}
-(void)startFlashAnimation;

@property (retain)	id <ADScreenFlashDelegate> delegate;

@end
