//
//  macro.h
//  AdMobDemo
//
//  Created by Qi Chen on 11/26/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#ifndef macro_h
#define macro_h

#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define MANAGED_OBJECT_CONTEXT APP_DELEGATE.persistentContainer.viewContext
#define WINDOW_WIDTH APP_DELEGATE.window.bounds.size.width
#define WINDOW_HEIGHT APP_DELEGATE.window.bounds.size.height

#endif /* macro_h */
