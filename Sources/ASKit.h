//
//  ASKit iOS.h
//  ASKit iOS
//
//  Created by AntScript on 26/10/2016.
//
//

#import <TargetConditionals.h>

#if TARGET_OS_MAC
    #import <AppKit/AppKit.h>
#else
    #import <UIKit/UIKit.h>
#endif


//! Project version number for ASKit iOS.
FOUNDATION_EXPORT double ASKitVersionNumber;

//! Project version string for ASKit iOS.
FOUNDATION_EXPORT const unsigned char ASKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ASKit_iOS/PublicHeader.h>


