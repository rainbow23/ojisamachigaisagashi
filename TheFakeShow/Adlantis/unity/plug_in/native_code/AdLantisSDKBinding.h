//
// Copyright 2011 Atlantis, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//


#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
  AdViewTop,
  AdViewBottom,
  AdViewLeft,
  AdViewRight,
} AdViewPosition;
  
#ifdef __OBJC__  
@class AdlantisView;

void AdView_Set(AdlantisView *adView);
AdlantisView *AdView();
  
AdlantisView* AdView_Init();
  
#endif
  
void _AdView_SetPublisherId(char * id);
void _AdView_SetGapPublisherId(char * id);

void _AdView_ShowHide(bool show);
void _AdView_Collapse(bool collapse);
void _AdView_FadeIn();
void _AdView_FadeOut();
  
void _AdView_SetPosition(AdViewPosition position);
  
void _AdView_Log(char* s);
  
#ifdef __cplusplus
} /* closing brace for extern "C" */
#endif

