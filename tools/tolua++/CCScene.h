enum tOrientation{};
module CCOrientation
{
	#define kCCTransitionOrientationLeftOver @ Left
	#define kCCTransitionOrientationRightOver @ Right
	#define kCCTransitionOrientationUpOver @ Up
	#define kCCTransitionOrientationDownOver @ Down	
}

class CCScene: public CCNode
{
	static CCScene* create();
	static tolua_outside CCScene* CCTransitionSceneOriented::create @ oriented(float duration, CCScene* nextScene, tOrientation orientation);
	static tolua_outside CCScene* CCTransitionRotoZoom::create @ rotoZoom(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionJumpZoom::create @ jumpZoom(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionShrinkGrow::create @ shrinkGrow(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionFlipX::create @ flipX(float duration, CCScene* nextScene, tOrientation orientation);
	static tolua_outside CCScene* CCTransitionFlipY::create @ flipY(float duration, CCScene* nextScene, tOrientation orientation);
	static tolua_outside CCScene* CCTransitionFlipAngular::create @ flipAngular(float duration, CCScene* nextScene, tOrientation orientation);
	static tolua_outside CCScene* CCTransitionZoomFlipX::create @ zoomFlipX(float duration, CCScene* nextScene, tOrientation orientation);
	static tolua_outside CCScene* CCTransitionZoomFlipY::create @ zoomFlipY(float duration, CCScene* nextScene, tOrientation orientation);
	static tolua_outside CCScene* CCTransitionZoomFlipAngular::create @ zoomFlipAngular(float duration, CCScene* nextScene, tOrientation orientation);
	static tolua_outside CCScene* CCTransitionFade::create @ fade(float duration, CCScene* nextScene, ccColor3& color);
	static tolua_outside CCScene* CCTransitionCrossFade::create @ crossFade(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionTurnOffTiles::create @ turnOffTiles(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionSplitCols::create @ splitCols(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionSplitRows::create @ splitRows(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionPageTurn::create @ pageTurn(float duration, CCScene* nextScene, bool backward);
	static tolua_outside CCScene* CCTransitionProgressRadialCCW::create @ progressCCW(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionProgressRadialCW::create @ progressCW(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionProgressHorizontal::create @ progressH(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionProgressVertical::create @ progressV(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionProgressInOut::create @ progressIO(float duration, CCScene* nextScene);
	static tolua_outside CCScene* CCTransitionProgressOutIn::create @ progressOI(float duration, CCScene* nextScene);
	
	static tolua_outside CCScene* CCScene_createMove @ move(float duration, CCScene* nextScene, tOrientation orientation);
	static tolua_outside CCScene* CCScene_createSlide @ slide(float duration, CCScene* nextScene, tOrientation orientation);
	static tolua_outside CCScene* CCScene_createFadeTiles @ fadeTiles(float duration, CCScene* nextScene, tOrientation orientation);
};
